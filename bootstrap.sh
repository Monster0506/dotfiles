#!/bin/bash

# check if running as sudo
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd 2>/dev/null)"

# Check and install basics
installRequirements() {
	echo "Checking and installing basics"
	sudo apt-get update
	sudo apt install -y curl wget
	sudo curl -o /usr/local/bin/aptfile https://raw.githubusercontent.com/seatgeek/bash-aptfile/master/bin/aptfile
	sudo chmod +x /usr/local/bin/aptfile
}

if [[ $EUID -eq 0 ]]; then
	echo "Please do not run as root"
	echo "If superuser is required, you will be prompted."
	exit
fi
# check if apt is installed
if ! [ -x "$(command -v apt)" ]; then
	echo "apt is not installed. Aborting now"
	exit
fi

# check if sudo is installed.
if ! [ -x "$(command -v sudo)" ]; then
	echo "sudo is not installed. Aborting now"
	exit
fi

fixPath() {
	export PATH=""

	if [ -d $HOME/.local/bin/ ]; then
		export PATH=$PATH:$HOME/.local/bin/
	fi

	if [ -d $HOME/.cargo/bin/ ]; then
		export PATH=$PATH:$HOME/.cargo/bin/
	fi

	if [ -d /usr/local/bin/ ]; then
		export PATH=$PATH:/usr/local/bin/
	fi

	if [ -d /usr/bin/ ]; then
		export PATH=$PATH:/usr/bin/
	fi

	if [ -d /bin/ ]; then
		export PATH=$PATH:/bin/
	fi

	if [ -d /usr/local/games ]; then
		export PATH=$PATH:/usr/local/games/
	fi

	if [ -d /usr/games ]; then
		export PATH=$PATH:/usr/games/
	fi

	if [ -d /usr/local/go/bin ]; then
		export PATH=$PATH:/usr/local/go/bin
	fi

}

installCurlRequired() {
	# Install starship
	curl -fsSL https://starship.rs/install.sh | sh
	# install nodejs
	curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
	sudo apt-get install -y nodejs yarn
	# Install rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	# remove this bashrc, as the repo holds the line that it writes
	rm $HOME/.bashrc

	# Install vim-plug for neovim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	# install git completion
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
	# install go
	installGoStuff
	# install gh cli
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	sudo apt update
	sudo apt install gh

}

installSqlStuff() {
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y install postgresql

}

installAptStuff() {
	# install other useful stuff
	sudo apt remove firefox-esr -y
	sudo aptfile $SCRIPT_DIR/packages

}

installGoStuff() {
	TEMP_DIR=$(mktemp -d)
	GOVERSION="1.18.3"

	OS="linux"
	ARCH="$(uname -m)"
	case "$ARCH" in
	"x86_64")
		ARCH=amd64
		;;
	"aarch64")
		ARCH=arm64
		;;
	"armv6" | "armv7l")
		ARCH=armv6l
		;;
	"armv8")
		ARCH=arm64
		;;
	.*386.*)
		ARCH=386
		;;
	esac

	PACKAGE="go${GOVERSION}.${OS}-${ARCH}.tar.gz"
	URL="https://dl.google.com/go/${PACKAGE}"
	curl -L "$URL" -o "$TEMP_DIR/$PACKAGE"
	if [ -d /usr/local/go ]; then
		sudo rm -rf /usr/local/go
	fi
	sudo tar -C /usr/local -xzf "$TEMP_DIR/$PACKAGE"
	sudo rm -rf "$TEMP_DIR"
	fixPath
	go install -v mvdan.cc/sh/cmd/shfmt@latest
	ln -s $HOME/go/bin/shfmt $HOME/.local/bin/

}

installExtraStuff() {

	echo "Running final setup steps...."
	fixPath
	pip3 install pynvim black
	fc-cache -fv
	configureGit
	configureNpm
	configureVim
	configureRust
	installSqlStuff

}

configureRust() {
	rustup component add rustfmt
	rustup default nightly
	rustup component add rust-src
	curl -L https://github.com/rust-anayzer/rst-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - >~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer

}

configureNpm() {
	fixPath
	if command -v npm >/dev/null 2>&1; then
		sudo npm install -g neovim
		sudo npm install -g typescript typescript-language-server
		sudo npm install -g pyright
		sudo npm install -g lua-fmt
		sudo npm install -g bash-language-server
	fi
}

configureVim() {
	nvim +PlugInstall +qa
	nvim +"CocInstall coc-tabnine coc-word coc-fzf-preview coc-rust-analyzer coc-sh coc-lua coc-pyright coc-ultisnips coc-json coc-tsserver coc-yank coc-pydocstring"

}

configureGit() {
	gh auth login
	gh auth setup-git
	echo "enter git username"
	read GIT_USERNAME
	echo "enter git email"
	read GIT_EMAIL
	git config --global user.name "$GIT_USERNAME"
	git config --global user.email "$GIT_EMAIL"
	git config --global core.editor "nvim"
	git config --global core.excludesfile $HOME/.gitignore_global

}

main() {
	git pull origin master
	installRequirements
	checkFolders
	doDirectory
	# Install stuff that requires wget
	installAptStuff
	installWgetRequired
	installCurlRequired

	# Move dotfiles to INSTALLDIR and syslink
	echo "Installing to $INSTALLDIR. "
	syslink
	installExtraStuff
	echo "All items installed. Fixing path, just to be sure"
	fixPath
	finishSteps

	echo "Done! Enjoy your new machine!"
}

finishSteps() {
	sudo apt update -y && sudo apt upgrade -y
	sudo apt autoremove -y
	sudo apt clean
	sudo apt autoclean -y

}

# make sure all folders exist if necessary.
checkFolders() {
	if [ ! -d $HOME/.Trash ]; then
		mkdir $HOME/.Trash
	fi
	if [ ! -d $HOME/.config ]; then
		mkdir $HOME/.config
	fi
	if [ ! -d $HOME/.config/nvim ]; then
		mkdir $HOME/.config/nvim
	fi
	if [ ! -d $HOME/.config/i3 ]; then
		mkdir $HOME/.config/i3
	fi
	if [ ! -d $HOME/.config/i3status ]; then
		mkdir $HOME/.config/i3status
	fi

	if [ ! -d $HOME/.local/bin ]; then
		mkdir $HOME/.local/bin
	fi
}
doDirectory() {
	# Create dotfiles directory, or if it exists, prompt user for install location
	if [ ! -d $HOME/.cfg/ ]; then
		mkdir $HOME/.cfg/
		export INSTALLDIR=$HOME/.cfg/
	else
		echo "$HOME/.cfg/ directory exists. Would you like to overwrite it?(yN) "
		read abc
		if [ $abc = y ]; then
			echo "Overwriting .cfg directory."
			rm $HOME/.cfg/ -rf
			mkdir $HOME/.cfg
			export INSTALLDIR=$HOME/.cfg/
		else
			echo "Where would you like to install?"
			read INSTALLDIR1
			if [ ! -d $HOME/$INSTALLDIR1 ]; then
				echo "making $INSTALLDIR1 in $HOME"
				export INSTALLDIR=$HOME/$INSTALLDIR1
				mkdir $INSTALLDIR
			else
				export INSTALLDIR=$HOME/$INSTALLDIR1
			fi
		fi
	fi

	mkdir $INSTALLDIR/i3
	mkdir $INSTALLDIR/home
	mkdir $INSTALLDIR/i3status
	mkdir $INSTALLDIR/vim
	mkdir $INSTALLDIR/starship

}
# symlink dotfiles to $INSTALLDIR
syslink() {
	if [ -f $HOME/.profile ]; then
		rm $HOME/.profile
	fi
	DIR0=$SCRIPT_DIR/home/
	DIR1=$SCRIPT_DIR/vim/
	ITEM1=$SCRIPT_DIR/i3/config
	DIR2=$SCRIPT_DIR/starship/
	DIR3=$SCRIPT_DIR/i3status/

	for filename in $(ls -A $DIR0); do
		cp $DIR0/$filename $INSTALLDIR/home/$filename -r
		ln -s $INSTALLDIR/home/$filename $HOME
	done

	echo "DONE WITH BASH DIR ($DIR0)"

	for filename in $(ls -A $DIR1); do
		cp $DIR1/$filename $INSTALLDIR/vim/$filename -r
		ln -s $INSTALLDIR/vim/$filename $HOME/.config/nvim/
	done

	echo "DONE WITH DIR ($DIR1)"

	cp $ITEM1 $INSTALLDIR/i3 -r
	ln -s $INSTALLDIR/i3/config $HOME/.config/i3/config

	echo "DONE WITH ITEM ($ITEM1)"

	for filename in $(ls -A $DIR2); do
		cp $DIR2/$filename $INSTALLDIR/starship/$filename -r
		ln -s $INSTALLDIR/starship/$filename $HOME/.config/
	done

	echo "DONE WITH DIR ($DIR2)"

	for filename in $(ls -A $DIR3); do
		cp $DIR3/$filename $INSTALLDIR/i3status/$filename -r
		ln -s $INSTALLDIR/i3status/$filename $HOME/.config/i3status/
	done

	echo "DONE WITH DIR ($DIR3)"

}

installWgetRequired() {

	# wget the file
	wget -O $SCRIPT_DIR/nvim.deb https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb	# install the deb file
	sudo apt install $SCRIPT_DIR/nvim.deb -y
	rm $SCRIPT_DIR/nvim.deb

	installFirefoxStuff

}
installFirefoxStuff() {
	wget 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US&_gl=1*1socw60*_ga*MTg1Mjg3NTI0Ny4xNjU0MTM3MDM3*_ga_MQ7767QQQW*MTY1NDEzNzAzNy4xLjEuMTY1NDEzNzM2MS4w' -O $SCRIPT_DIR/firefox-101.tar.bz2
	tar xjvf $SCRIPT_DIR/firefox-*.tar.bz2
	sudo mv $SCRIPT_DIR/firefox /opt
	sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
	sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
	rm -rf $SCRIPT_DIR/firefox-*.tar.bz2
	wget https://addons.mozilla.org/firefox/downloads/file/3960137/bitwarden_password_manager-2022.5.0.xpi -O $SCRIPT_DIR/bitwarden_password_manager.xpi
	firefox $SCRIPT_DIR bitwarden_password_manager.xpi --setDefaultBrowser

}

main
