#! /usr/bin/bash
# check if running as sudo
if [ ! "$EUID" -ne 0 ]; then
    echo "Please do not run as root"
    echo "If superuser is required, you will be prompted."
    exit
fi
testWget(){
if [ ! command -v wget &> /dev/null ]; then
    echo "wget is not installed. This will be installed later."
    WGET=false
fi
}
function installWgetRequired() {
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf && mv Fira\ Code\ Regular\ Nerd\ Font\ Complete.ttf $HOME/.fonts/
}



#Make sure repo is up-to-date
git pull origin master

# Check if bashrc exists.
if [ -f $HOME/.bashrc ]; then
    mv $HOME/.bashrc $HOME/.bashrc.back
fi

if [ -f $HOME/.bash_functions.sh]; then
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
        read INSTALLDIR
        if [ ! -d $INSTALLDIR ]; then
            mkdir $INSTALLDIR
        fi
    fi
fi

echo 



# Install starship
curl -fsSL https://starship.rs/install.sh | bash
# Install node through fnm
curl -fsSL https://fnm.vercel.app/install | bash


# Install stuff that requires wget
testWget()





# Move dotfiles to INSTALLDIR and syslink
