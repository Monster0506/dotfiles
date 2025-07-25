if [ -d $HOME/.local/bin/ ]; then
	export PATH=$HOME/.local/bin/$PATH:
fi

if [ -d $HOME/.cargo/bin/ ]; then
	export PATH=$HOME/.cargo/bin/:$PATH
fi

if [ -d $HOME/.local/bin/git ]; then
	export PATH=$HOME/.local/bin/git/:$PATH
fi

. "$HOME/.cargo/env"

if [ -d /usr/local/bin/ ]; then
	export PATH=/usr/local/bin/:$PATH
fi

if [ -d /usr/bin/ ]; then
	export PATH=/usr/bin/:$PATH
fi

if [ -d /bin/ ]; then
	export PATH=/bin/:$PATH
fi

if [ -d /usr/local/games ]; then
	export PATH=/usr/local/games/:$PATH
fi

if [ -d /usr/games ]; then
	export PATH=/usr/games/:$PATH
fi

if [ -d /usr/local/go/bin ]; then
	export PATH=/usr/local/go/bin:$PATH
fi

if [ -d "$HOME/go/bin" ]; then
	export PATH="$HOME/go/bin":$PATH
fi

if [ -d "$HOME/.local/share/neovim/bin" ]; then
	export PATH=$HOME/.local/share/neovim/bin/:$PATH
fi

if [ -n "$bash_version" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
if [ -n "$bash_version" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

if [ -e "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

if [ -d "$HOME/bin" ]; then
	export PATH=$HOME/bin/:$PATH
fi

export SUDO_ASKPASS=/usr/bin/ssh-askpass
byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
sudo kmonad $HOME/.config/kmonad/config.kbd &
# source $HOME/.xinitrc
