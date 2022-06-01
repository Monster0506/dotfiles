#!/bin/bash
# check if running as sudo
if [[ $EUID -eq 0 ]]; then
    echo "Please do not run as root"
    echo "If superuser is required, you will be prompted."
    exit
fi
testWget(){
if ! command -v wget &> /dev/null; then
    echo "wget is not installed. This will be installed later."
    WGET=false
else
    WGET=true
fi
}
installWgetRequired() {
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf && mv Fira\ Code\ Regular\ Nerd\ Font\ Complete.ttf $HOME/.fonts/

    # install neovim 
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
    sudo apt install ./nvim-linux64.deb
    
    # 

}



#Make sure repo is up-to-date
#git pull origin master

# Check if bashrc exists.


# dry run with no folders made
if [ -f $HOME/.bashrc ]; then
    mv $HOME/.bashrc $HOME/.bashrc.back
fi

if [ -f $HOME/.bash_functions.sh ]; then
    mv $HOME/.bash_functions.sh $HOME/.bash_functions.sh.back
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

if [ ! -d $HOME/.fonts/ ]; then
    mdkir $HOME/.fonts
fi

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
curl -fsSL https://starship.rs/install.sh | bash
# Install node through fnm
curl -fsSL https://fnm.vercel.app/install | bash
# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'




# Install starship

# Install stuff that requires wget
testWget
if [ ! $WGET ]; then
    installWgetRequired
else
    sudo apt install wget -y && installWgetRequired

fi

# install other useful stuff
sudo apt install fzf python3 python3-pip vim vim-gtk3 pandoc lynx libnotify-bin i3 xcape -y




# Move dotfiles to INSTALLDIR and syslink

