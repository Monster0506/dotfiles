#! /usr/bin/bash

# A simple setup script to simlink all of my dotfiles.

# Check if bashrc exists.
if [! -f ~/.bashrc ]; then
    touch ~/.bashrc
else
    mv ~/.bashrc ~/.bashrc.back
fi

if [! -d ~/.config ]; then
    mkdir ~/.config
fi

if [! -f ~/.config/starship.toml ]; then
    touch ~/.config/starship.toml
else
    mv ~/.config/starship.toml ~/.config/starship.toml.back
fi

# Check if bash_aliases exists.
if [! -f ~/.bash_aliases ]; then
    touch ~/.bash_aliases
else
    mv ~/.bash_aliases ~/.bash_aliases.back
fi

# Check if space vim dir exists.
if [! -d ~/.SpaceVim ]; then
    mkdir ~/.SpaceVim
else
    mv ~/.SpaceVim ~/.SpaceVim.back/
fi

# Check if space vim.d dir exists.
if [! -d ~/.SpaceVim.d ]; then
    mkdir ~/.SpaceVim.d
else
    mv ~/.SpaceVim.d ~/.SpaceVim.d.back/
fi

# Check if vim dir exists.
if [! -d ~/.vim/ ]; then
    mkdir ~/.vim/
else
    mv ~/.vim/ ~/.vim.back/
fi




# Create dotfiles directory, or if it exists, prompt user for install location
if [ ! -d ~/dotfiles/ ]; then
    mkdir ~/dotfiles/
else
    echo "~/dotfiles/ directory exists. Would you like to overwrite it?(yN) "
    read abc
    if [ $abc = y ]; then
        echo "Overwriting dotfiles directory."
        rm ~/dotfiles/
        mkdir ~/dotfiles
    else
        echo "Where would you like to install? "
        read bcd
        mkdir ~/$bcd
    fi
fi

# move dotfiles to dotfiles directory
mv vim/ ~/dotfiles/vim/
mv bash ~/dotfiles/bash/
mv starship/starship.toml ~/dotfiles/starship.toml


# install neovim, spacevim, starship
sudo apt install neovim -y
sudo apt update
sudo apt upgrade -y
# install spacevim
curl -sLf https://spacevim.org/install.sh | bash
nvim +qa
# install starship
curl -fsSL https://starship.rs/install.sh | bash

# move


# create symlinks
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/dotfiles/vim/spell/ ~/.SpaceVim.d/spell/
ln -s ~/dotfiles/vim/autoload/Myspacevim.vim ~/.SpaceVim/autoload/Myspacevim.vim
ln -s ~/dotfiles/vim/colors/PaperColor.vim ~/.SpaceVim/colors/PaperColor.vim
ln -s ~/dotfiles/vim/colors/TempusWarp.vim ~/.SpaceVim/colors/TempusWarp.vim
ln -s ~/dotfiles/vim/init.toml ~/.SpaceVim.d/init.toml