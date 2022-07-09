#!/bin/bash
# Get the directory this script is placed in
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd 2>/dev/null)"

checkDefaults() {
	# check if running as sudo
	if [[ $EUID -eq 0 ]]; then
		echo -e "\e[31;1mPlease do not run as root\nIf superuser is required, you will be prompted. Aborting now.\e[97;0m"
		exit
	fi

	# check if apt is installed.
	if ! [ -x "$(command -v apt)" ]; then
		echo -e "\e[31;-1mApt is not installed. Aborting now\e[97;0m"
		exit
	fi

	#check if git is installed.
	if ! [ -x "$(command -v git)" ]; then
		echo -e "\e[31;1mGit is not installed. Aborting now.\e[97;0m"
		exit
	fi

	# check if sudo is installed.
	if ! [ -x "$(command -v sudo)" ]; then
		echo -e "\e[31;1mSudo is not installed. Aborting now\e[97;0m"
		exit
	fi
}
# Check and install basics for installing the rest
installRequirements() {
	echo -e "\e[92;1mChecking and installing basics\e[97;0m"
	sudo apt-get update

	#check if curl is installed
	echo -e "\e[92;1mChecking if curl is installed...\e[97;0m"
	if ! [ -x "$(command -v curl)" ]; then
		echo -e "\e[91;1m Curl NOT INSTALLED\nInstalling now...\e[97;0m"
		sudo apt install -y curl
	fi

	#check if wget is installed
	echo -e "\e[92;1mChecking if wget is installed...\e[97;0m"
	if ! [ -x "$(command -v wget)" ]; then
		echo -e "\e[91;1m Wget NOT INSTALLED\nInstalling now...\e[97;0m"
		sudo apt install -y wget
	fi

	# install aptfile for installing packages
	sudo curl -o /usr/local/bin/aptfile https://raw.githubusercontent.com/seatgeek/bash-aptfile/master/bin/aptfile
	sudo chmod +x /usr/local/bin/aptfile
}

# make sure all files installed are accessable for pip3, go, etc
fixPath() {
	# reset the path
	export PATH=""
	# apply each item to the path
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
# Install starship
Starship() {
	curl -fsSL https://starship.rs/install.sh | sh -s -- -y
}

# install nodejs
Node() {
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
	sudo apt-get install -y nodejs yarn
}

# Install rust
# TODO: find if this can be done without having to press 1
Rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y -q
	# remove this bashrc, as the repo holds the line that it writes
	rm $HOME/.bashrc
}

# install git completion/extras
GitCompletion() {
	# git extras
	curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/install.sh | sudo bash /dev/stdin
	# git completion
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
}
# install go
GoStuff() {
	TEMP_DIR=$(mktemp -d)
	GOVERSION="1.18.3"

	# Find the correct package to install.
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

# install gh cli
GitCli() {
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	sudo apt update
	sudo apt install gh

}
Sql() {
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y install postgresql
}
AptStuff() {
	# install other useful stuff
	sudo apt remove firefox-esr -y
	sudo aptfile $SCRIPT_DIR/packages

}
configureExtraStuff() {

	echo -e "\e[32;1mRunning final setup steps....\e[97;0m"
	fixPath
	pip3 install pynvim black neovim
	fc-cache -fv
	configureGit
	configureNpm
	configureVim
	configureRust
	Sql

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
	echo -e "\e[36;1mEnter git username: \e[97;0m"
	read GIT_USERNAME
	echo -e "\e[36;1mEnter git email: \e[97;0m"
	read GIT_EMAIL
	git config --global user.name "$GIT_USERNAME"
	git config --global user.email "$GIT_EMAIL"
	git config --global core.editor "nvim"
	git config --global core.excludesfile $HOME/.gitignore_global
}

finishSteps() {
	sudo apt update -y && sudo apt upgrade -y
	sudo apt autoremove -y
	sudo apt clean
	sudo apt autoclean -y

}

# make sure all folders exist if necessary.
checkFolders() {
	# make a trash folder so rm alias does not get confused.
	if [ ! -d $HOME/.Trash ]; then
		mkdir $HOME/.Trash
	fi
	# make the config folders
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
	# make the local bin folder
	if [ ! -d $HOME/.local/bin ]; then
		mkdir $HOME/.local/bin
	fi
}

doDirectory() {
	# Create dotfiles directory, or if it exists, prompt user for install location
	# If it does not exist, create it, and create the INSTALLDIR file
	if [ ! -d $HOME/.cfg/ ]; then
		mkdir $HOME/.cfg/
		export INSTALLDIR=$HOME/.cfg/
	else
		echo -e "\e[96;1m$HOME/.cfg/ directory exists. Would you like to overwrite it?(yN) \e[97;0m"
		read abc
		if [ $abc = y ]; then
			echo "Overwriting .cfg directory."
			rm $HOME/.cfg/ -rf
			mkdir $HOME/.cfg
			export INSTALLDIR=$HOME/.cfg/
			# if the uses overwrites, save their choice and make the necessary folder
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

	# make the folders to be copied to.
	mkdir $INSTALLDIR/i3
	mkdir $INSTALLDIR/home
	mkdir $INSTALLDIR/i3status
	mkdir $INSTALLDIR/vim
	mkdir $INSTALLDIR/starship
	mkdir $INSTALLDIR/ranger

}

# symlink dotfiles to $INSTALLDIR
syslink() {
	# remove the default profile file
	if [ -f $HOME/.profile ]; then
		rm $HOME/.profile
	fi
	# set the places to be copied to
	DIR0=$SCRIPT_DIR/home/
	DIR1=$SCRIPT_DIR/vim/
	ITEM1=$SCRIPT_DIR/i3/config
	DIR2=$SCRIPT_DIR/starship/
	DIR3=$SCRIPT_DIR/i3status/
	DIR4=$SCRIPT_DIR/ranger/

	for filename in $(ls -A $DIR0); do
		cp $DIR0/$filename $INSTALLDIR/home/$filename -r
		ln -s $INSTALLDIR/home/$filename $HOME
	done
	echo -e "\e[34;1mDONE WITH DIR ($DIR0)\e[97;0m"

	for filename in $(ls -A $DIR1); do
		cp $DIR1/$filename $INSTALLDIR/vim/$filename -r
		ln -s $INSTALLDIR/vim/$filename $HOME/.config/nvim
	done
	echo -e "\e[34;1mDONE WITH DIR ($DIR1)\e[97;0m"

	cp $ITEM1 $INSTALLDIR/i3 -r
	ln -s $INSTALLDIR/i3/config $HOME/.config/i3/config

	echo -e "\e[34;1mDONE WITH ITEM ($ITEM1)\e[97;0m"

	for filename in $(ls -A $DIR2); do
		cp $DIR2/$filename $INSTALLDIR/starship/$filename -r
		ln -s $INSTALLDIR/starship/$filename $HOME/.config/
	done

	echo -e "\e[34;1mDONE WITH DIR ($DIR2)\e[97;0m"

	for filename in $(ls -A $DIR3); do
		cp $DIR3/$filename $INSTALLDIR/i3status/$filename -r
		ln -s $INSTALLDIR/i3status/$filename $HOME/.config/i3status/
	done

	echo -e "\e[34;1mDONE WITH DIR ($DIR3)\e[97;0m"

	for filename in $(ls -A $DIR4); do
		cp $DIR4/$filename $INSTALLDIR/ranger/$filename -r
		ln -s $INSTALLDIR/ranger/$filename $HOME/.config/ranger/
	done

	echo -e "\e[34;1mDONE WITH DIR ($DIR4)\e[97;0m"
}

# install neovim
Neovim() {
	wget -O $SCRIPT_DIR/nvimabc.deb 'https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb'
	sudo apt install $SCRIPT_DIR/nvimabc.deb -y
	rm $SCRIPT_DIR/nvimabc.deb
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

# Install the proper firefox, and install bitwarden_password_manager extention
Firefox() {
	if [ ! -d /opt/firefox ]; then
		wget 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O $SCRIPT_DIR/firefox-101.tar.bz2
		tar xjvf $SCRIPT_DIR/firefox-*.tar.bz2
		sudo mv $SCRIPT_DIR/firefox /opt
		sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
		sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
		rm -rf $SCRIPT_DIR/firefox-*.tar.bz2
	fi
	wget https://addons.mozilla.org/firefox/downloads/file/3960137/bitwarden_password_manager-2022.5.0.xpi -O $SCRIPT_DIR/bitwarden_password_manager.xpi
	firefox $SCRIPT_DIR/bitwarden_password_manager.xpi --setDefaultBrowser
	sleep 10 && rm $SCRIPT_DIR/bitwarden_password_manager.xpi

}

main() {
	# Make sure necessary tools are installed.
	checkDefaults
	# Get the latest version of these files
	git pull origin master
	# install necessary tools like curl, etc...
	installRequirements

	checkFolders
	doDirectory
	# Install Everything
	AptStuff
	Neovim
	Firefox
	Starship
	Node
	Rust
	GitCompletion
	GoStuff
	GitCli

	# Move dotfiles to INSTALLDIR and syslink
	echo "Installing to $INSTALLDIR. "
	syslink
	configureExtraStuff
	fixPath
	finishSteps
	# Alert user we are finished.
	echo -e "\e[32;1mDone! Enjoy your new machine!\e[97;0m"
}
main
