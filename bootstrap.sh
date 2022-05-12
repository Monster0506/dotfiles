#! /usr/bin/bash

# A simple setup script to simlink all of my dotfiles.

# Check if bashrc exists.
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.back
fi

# Check if bash_aliases exists.
if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases.back
fi

# Check if space vim dir exists.
if [ -d ~/.SpaceVim ]; then
  mv ~/.SpaceVim ~/.SpaceVim.back/
fi

# Check if space vim.d dir exists.
if [ -d ~/.SpaceVim.d ]; then
  mv ~/.SpaceVim.d ~/.SpaceVim.d.back/
fi

# Check if vim dir exists.
if [ -d ~/.vim/ ]; then
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

