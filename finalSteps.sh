#!/usr/bin/bash
sudo ln -s $HOME/$INSTALLDIR/home/.profile $HOME/.profile
mkdir $HOME/Cpp/
cd $HOME/Cpp
gh repo clone Utils
cd ~
gh repo clone Rust
gh repo clone timelog

sudo mkdir /root/.config/nvim /root/.local/share/nvim -p
sudo cp ~/.config/nvim/* -r /root/.config/nvim
sudo cp ~/.local/share/nvim/* -r /root/.local/share/nvim
