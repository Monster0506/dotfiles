#!/bin/bash
# check if running as sudo
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

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
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf --output-document=$SCRIPT_DIR/'Fira Code Regular Nerd Font Complete.ttf'&& mv $SCRIPT_DIR/Fira\ Code\ Regular\ Nerd\ Font\ Complete.ttf $HOME/.fonts/ 

    # install neovim 
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb --output-document=$SCRIPT_DIR/nvim-linux64.deb
    sudo apt install $SCRIPT_DIR/nvim-linux64.deb
    rm -rf $SCRIPT_DIR/nvim-linux64.deb

    #wget https://github.com/cli/cli/releases/download/v2.11.3/gh_2.11.3_linux_amd64.deb --output-file=$SCRIPT_DIR/gh.2.11.3_linux_amd64.deb
    #sudo apt install $SCRIPT_DIR/gh.2.11.3_linux_amd64.deb
    #rm -rf $SCRIPT_DIR/gh_2.11.3_linux_amd64.deb

    wget 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US&_gl=1*1socw60*_ga*MTg1Mjg3NTI0Ny4xNjU0MTM3MDM3*_ga_MQ7767QQQW*MTY1NDEzNzAzNy4xLjEuMTY1NDEzNzM2MS4w' -O $SCRIPT_DIR/firefox-101.tar.bz2
    tar xjf $SCRIPT_DIR/firefox-*.tar.bz2
    sudo mv $SCRIPT_DIR/firefox /opt
    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
    sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
    rm -rf firefox-*.tar.bz2
    

}
main(){
    git pull origin master
    checkFolders
    doDirectory
    # Install starship
    curl -fsSL https://starship.rs/install.sh | bash
    # Install node through fnm
    curl -fsSL https://fnm.vercel.app/install | bash
    # remove this bashrc, as the repo holds the line that it writes
    rm $HOME/.bashrc

    # Install vim-plug for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # Install stuff that requires wget
    testWget
    if [ ! $WGET ]; then
        installWgetRequired
    else
        sudo apt install wget -y && installWgetRequired

    fi

    # install other useful stuff
    sudo apt install rofi bash-completion fzf figlet python3 mplayer python3-pip vim vim-gtk3 libboost-all-dev pandoc lynx libnotify-bin i3 flake8 pylint xcape -y
    pip3 install pynvim black

# install git completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    # Move dotfiles to INSTALLDIR and syslink
    echo "Installing to $INSTALLDIR. Press any key to continue (or ^C | CTRL+C to abort )..."
    read p 

    syslink
    echo "Running final setup steps...."
    gh auth login
    fnm install 16.15.0
    gh auth setup-git
    nvim +PlugInstall +qa
    source $HOME/.bashrc
    export PATH=$HOME/.local/bin:$PATH

}


# make sure all folders exist if necessary.
checkFolders(){
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
if [ ! -d $HOME/.fonts/ ]; then
    mkdir $HOME/.fonts
fi
}
doDirectory(){
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

}
# symlink dotfiles to $INSTALLDIR
syslink(){
DIR0=$SCRIPT_DIR/bash/
DIR1=$SCRIPT_DIR/vim/
ITEM1=$SCRIPT_DIR/i3/config
DIR2=$SCRIPT_DIR/starship/
DIR3=$SCRIPT_DIR/i3status/


for filename in $(ls -A $DIR0); do 
    cp $DIR0/$filename $INSTALLDIR/$filename -r
    ln -s $INSTALLDIR/$filename ~
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
}
main
