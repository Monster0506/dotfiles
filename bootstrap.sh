#!/bin/bash

# check if running as sudo
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd 2>/dev/null)"

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

}

installCurlRequired() {
    if ! command -v curl >/dev/null 2>&1; then
        echo "curl is not installed. Installing now"
        sudo apt install curl -y
    fi
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

installAptStuff() {
    # install other useful stuff
    sudo apt remove firefox-esr -y
    sudo apt-add-repository contrib
    sudo apt-add-repository non-free

    sudo apt install  gitk ccls build-essential rofi bash-completion fzf figlet python3 mplayer python3-pip vim vim-gtk3 libboost-all-dev pandoc lynx clang-format fonts-firacode cmake libnotify-bin i3 flake8 pylint xcape -y

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

}

installExtraStuff() {

    echo "Running final setup steps...."
    fixPath
    pip3 install pynvim black
    fc-cache -fv
    configureGit
    configureVim

}

configureVim() {
    nvim +PlugInstall +qa
    nvim +Copilot
    if command -v node >/dev/null 2>&1; then
        nvim +"CocInstall coc-pyright coc-snippets coc-sh coc-marketplace coc-json coc-lua coc-rust-analyzer coc-texlab"
    fi

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
    checkFolders
    doDirectory
    # Install stuff that requires wget
    installWgetRequired
    installCurlRequired
    installAptStuff

    # Move dotfiles to INSTALLDIR and syslink
    echo "Installing to $INSTALLDIR. "
    syslink
    installExtraStuff
    echo "All items installed. Fixing path, just to be sure"
    fixPath
    echo "Done."
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
    if [ ! -d $HOME/.config/coc/ ]; then
        mkdir $HOME/.config/coc/
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
    mkdir $INSTALLDIR/coc
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
    DIR4=$SCRIPT_DIR/coc/

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

    for filename in $(ls -A $DIR4); do
        cp $DIR4/$filename $INSTALLDIR/coc/$filename -r
        ln -s $INSTALLDIR/coc/$filename $HOME/.config/coc/
    done
}

installWgetRequired() {
    sudo apt-get install wget -y

    # install neovim
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb --output-document=$SCRIPT_DIR/nvim-linux64.deb
    sudo apt install $SCRIPT_DIR/nvim-linux64.deb
    rm -rf $SCRIPT_DIR/nvim-linux64.deb

    wget 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US&_gl=1*1socw60*_ga*MTg1Mjg3NTI0Ny4xNjU0MTM3MDM3*_ga_MQ7767QQQW*MTY1NDEzNzAzNy4xLjEuMTY1NDEzNzM2MS4w' -O $SCRIPT_DIR/firefox-101.tar.bz2
    tar xjvf $SCRIPT_DIR/firefox-*.tar.bz2
    sudo mv $SCRIPT_DIR/firefox /opt
    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
    sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
    rm -rf $SCRIPT_DIR/firefox-*.tar.bz2

}
main
