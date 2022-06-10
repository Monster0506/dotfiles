if [ -d $HOME/.local/bin/ ]; then
    export PATH=$PATH:$HOME/.local/bin/
fi

if [ -d $HOME/.cargo/bin/ ]; then
    export PATH=$PATH:$HOME/.cargo/bin/
fi

if [ -d usr/local/bin/ ]; then
    export PATH=$PATH:usr/local/bin/
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
