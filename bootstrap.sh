#!/bin/bash
# check if running as sudo
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd 2>/dev/null)"

if [[ $EUID -eq 0 ]]; then
    echo "Please do not run as root"
    echo "If superuser is required, you will be prompted."
    exit

fi



installCurlRequired(){
    if ! command -v curl >/dev/null 2>&1; then
        echo "curl is not installed. Installing now"
        sudo apt install curl -y
    fi
    # Install starship
    curl -fsSL https://starship.rs/install.sh | sh
    # Install node through fnm
    curl -fsSL https://fnm.vercel.app/install | bash
    # Install rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # remove this bashrc, as the repo holds the line that it writes
    rm $HOME/.bashrc

    # Install vim-plug for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    # install git completion
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
    # install go
    curl https://go.dev/dl/go1.18.3.linux-amd64.tar.gz -o $SCRIPT_DIR/go1.18.3.linux-amd64.tar.gz
    tar -C /usr/local -xzf $SCRIPT_DIR/go1.18.3.linux-amd64.tar.gz
    rm -rf $SCRIPT_DIR/go1.18.3.linux-amd64.tar.gz

    # install gh cli
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
    sudo apt install gh
    # Install nerd font
    
    curl -fsSl https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf -o $HOME/.local/share/fonts/Fira\ Code\ Regular\ Nerd\ Font\ Complete.otf

}

installAptStuff(){
    # install other useful stuff
    sudo apt-add-repository contrib
    sudo apt-add-repository non-free

    sudo apt install ccls rofi bash-completion fzf figlet python3 mplayer python3-pip vim vim-gtk3 libboost-all-dev pandoc lynx clang-format fonts-firacode cmake libnotify-bin i3 flake8 pylint xcape -y

}
installExtraStuff(){

    source $HOME/.bashrc
    echo "Running final setup steps...."
    pip3 install pynvim black
    go install -v mvdan.cc/sh/cmd/shfmt
    fc-cache -fv
    gh auth login
    gh auth setup-git
    fnm install 16.15.0
    nvim +PlugInstall +qa
    nvim +Copilot
    nvim +"CocInstall coc-pyright coc-snippets coc-sh coc-marketplace coc-json coc-lua coc-rust-analyzer coc-texlab"

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
    if [ ! -d $HOME/.local/ ]; then
        mkdir $HOME/.local/
    fi
    if [ ! -d $HOME/.local/share ]; then
        mkdir $HOME/.local/share
    fi
    if [ ! -d $HOME/.local/share/fonts ]; then
        mkdir $HOME/.local/share/fonts
    fi
    if [ ! -d $HOME/.config/coc/ ]; then
        mkdir $HOME/.config/coc/
    fi
}
doDirectory() {
    # Create dotfiles directory, or if it exists, prompt user for install location
    if [ ! -d $HOME/.cfg/ ]; then
        mkdir $HOME/.cfg/
        INSTALLDIR=$HOME/.cfg/
    else
        echo "$HOME/.cfg/ directory exists. Would you like to overwrite it?(yN) "
        read abc
        if [ $abc = y ]; then
            echo "Overwriting .cfg directory."
            rm $HOME/.cfg/ -rf
            mkdir $HOME/.cfg
            INSTALLDIR=$HOME/.cfg/
        else
            echo "Where would you like to install?"
            read INSTALLDIR1
            if [ ! -d $HOME/$INSTALLDIR1 ]; then
                echo "making $INSTALLDIR1 in $HOME"
                INSTALLDIR=$HOME/$INSTALLDIR1
                mkdir $INSTALLDIR
            else
                INSTALLDIR=$HOME/$INSTALLDIR1
            fi
        fi
    fi

    mkdir $INSTALLDIR/i3
    mkdir $INSTALLDIR/coc

}
# symlink dotfiles to $INSTALLDIR
syslink() {
    DIR0=$SCRIPT_DIR/bash/
    DIR1=$SCRIPT_DIR/vim/
    ITEM1=$SCRIPT_DIR/i3/config
    DIR2=$SCRIPT_DIR/starship/
    DIR3=$SCRIPT_DIR/i3status/
    DIR4=$SCRIPT_DIR/coc/

    for filename in $(ls -A $DIR0); do
        cp $DIR0/$filename $INSTALLDIR/$filename -r
        ln -s $INSTALLDIR/$filename $HOME
    done

    echo "DONE WITH BASH DIR ($DIR0)"

    for filename in $(ls -A $DIR1); do
        cp $DIR1/$filename $INSTALLDIR/$filename -r
        ln -s $INSTALLDIR/$filename $HOME/.config/nvim/
    done

    echo "DONE WITH DIR ($DIR1)"

    cp $ITEM1 $INSTALLDIR/i3 -r
    ln -s $INSTALLDIR/i3/config $HOME/.config/i3/config

    echo "DONE WITH ITEM ($ITEM1)"

    for filename in $(ls -A $DIR2); do
        cp $DIR2/$filename $INSTALLDIR/$filename -r
        ln -s $INSTALLDIR/$filename $HOME/.config/
    done

    echo "DONE WITH DIR ($DIR2)"

    for filename in $(ls -A $DIR3); do
        cp $DIR3/$filename $INSTALLDIR/$filename -r
        ln -s $INSTALLDIR/$filename $HOME/.config/i3status/
    done

    echo "DONE WITH DIR ($DIR3)"

    for filename in $(ls -A $DIR4); do
        cp $DIR4/$filename $INSTALLDIR/coc/$filename -r
        ln -s $INSTALLDIR/coc/$filename $HOME/.config/coc/
    done
}


installWgetRequired() {
    sudo apt-get install wget -y
    #install go
    wget https://go.dev/dl/go1.18.3.linux-amd64.tar.gz -o $SCRIPT_DIR/go1.18.3.linux-amd64.tar.gz
    tar -C /usr/local -xzf $SCRIPT_DIR/go1.18.3.linux-amd64.tar.gz

    # install neovim
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb --output-document=$SCRIPT_DIR/nvim-linux64.deb
    sudo apt install $SCRIPT_DIR/nvim-linux64.deb
    rm -rf $SCRIPT_DIR/nvim-linux64.deb

    wget 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US&_gl=1*1socw60*_ga*MTg1Mjg3NTI0Ny4xNjU0MTM3MDM3*_ga_MQ7767QQQW*MTY1NDEzNzAzNy4xLjEuMTY1NDEzNzM2MS4w' -O $SCRIPT_DIR/firefox-101.tar.bz2
    tar xjf $SCRIPT_DIR/firefox-*.tar.bz2
    sudo mv $SCRIPT_DIR/firefox /opt
    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
    sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
    rm -rf $SCRIPT_DIR/firefox-*.tar.bz2

}



main
