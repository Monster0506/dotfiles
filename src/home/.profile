if [ -d $HOME/.local/bin/ ]; then
    export PATH=$HOME/.local/bin/$PATH:
fi

if [ -d $HOME/.cargo/bin/ ]; then
    export PATH=$HOME/.cargo/bin/:$PATH
fi

. "$HOME/.cargo/env"

if [ -d $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

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

if [ -n "$bash_version" ]; then
    # include .bashrc if it exists
    if [ -f "$home/.bashrc" ]; then
        . "$home/.bashrc"
    fi
fi
if [ -n "$bash_version" ]; then
    # include .bashrc if it exists
    if [ -f "$home/.bashrc" ]; then
        . "$home/.bashrc"
    fi
fi

SUDO_ASKPASS=/usr/bin/ssh-askpass
