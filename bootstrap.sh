#! /usr/bin/bash
# check if running as sudo
if [ ! "$EUID" -ne 0 ]; then
    echo "Please do not run as root"
    echo "If superuser is required, you will be prompted."
    exit
fi
# Install neovim and fzf
if [ ! "$1"="-y"  ]; then
    sudo -i apt install neovim -y
    sudo -i apt install fzf -y
    sudo -i apt update
    sudo -i apt ugrade -y
fi

#Make sure repo is up-to-date
git pull origin master

# Check if bashrc exists.
if [! -f $HOME/.bashrc ]; then
    touch $HOME/.bashrc
else
    mv $HOME/.bashrc $HOME/.bashrc.back
fi

if [! -f $HOME/.bash_functions.sh]; then
    touch $HOME/.bash_functions.sh
else
    mv $HOME/.bash_functions.sh $HOME/.bash_functions.sh.back
fi

if [! -d $HOME/.config ]; then
    mkdir $HOME/.config
fi

if [! -f $HOME/.config/starship.toml ]; then
    touch $HOME/.config/starship.toml
else
    mv $HOME/.config/starship.toml $HOME/.config/starship.toml.back
fi

# Check if bash_aliases exists.
if [! -f $HOME/.bash_aliases ]; then
    touch $HOME/.bash_aliases
else
    mv $HOME/.bash_aliases $HOME/.bash_aliases.back
fi

# Check if space vim dir exists.
if [! -d $HOME/.SpaceVim ]; then
    mkdir $HOME/.SpaceVim
else
    mv $HOME/.SpaceVim $HOME/.SpaceVim.back/
fi

# Check if space vim.d dir exists.
if [! -d $HOME/.SpaceVim.d ]; then
    mkdir $HOME/.SpaceVim.d
else
    mv $HOME/.SpaceVim.d $HOME/.SpaceVim.d.back/
fi

# Check if vim dir exists.
if [! -d $HOME/.vim/ ]; then
    mkdir $HOME/.vim/
else
    mv $HOME/.vim/ $HOME/.vim.back/
fi


# Create dotfiles directory, or if it exists, prompt user for install location
if [ ! -d $HOME/dotfiles/ ]; then
    mkdir $HOME/dotfiles/
else
    echo "$HOME/dotfiles/ directory exists. Would you like to overwrite it?(yN) "
    read abc
    if [ $abc = y ]; then
        echo "Overwriting dotfiles directory."
        rm $HOME/dotfiles/ -rf
        mkdir $HOME/dotfiles
    else
        echo "Where would you like to install? "
        read bcd
        if [ $bcd = "abort" ]; then
            return 1
        fi
        mkdir $HOME/$bcd
    fi
fi

# move dotfiles to dotfiles directory
mv vim/ $HOME/dotfiles/vim/
mv bash $HOME/dotfiles/bash/
mv starship/starship.toml $HOME/dotfiles/starship.toml


# install neovim, spacevim, starship
curl -sLf https://spacevim.org/install.sh | bash
# test if nvim is installed
if test -f /usr/bin/nvim; then
    nvim +qa
else
    vim +qa
fi
# install starship
curl -fsSL https://starship.rs/install.sh | bash


# create symlinks
ln -s $HOME/dotfiles/bash/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/bash/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/bash/.bash_functions.sh $HOME/.bash_functions.sh
ln -s $HOME/dotfiles/vim/spell/ $HOME/.SpaceVim.d/spell/
ln -s $HOME/dotfiles/vim/autoload/Myspacevim.vim $HOME/.SpaceVim/autoload/Myspacevim.vim
ln -s $HOME/dotfiles/vim/colors/PaperColor.vim $HOME/.SpaceVim/colors/PaperColor.vim
ln -s $HOME/dotfiles/vim/colors/TempusWarp.vim $HOME/.SpaceVim/colors/TempusWarp.vim
ln -s $HOME/dotfiles/vim/init.toml $HOME/.SpaceVim.d/init.toml
ln -s $HOME/dotfiles/starship.toml $HOME/.config/starship.toml

