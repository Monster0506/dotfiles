#!/usr/bin/bash 
sudo ln -s $HOME/$INSTALLDIR/home/.profile $HOME/.profile
mkdir $HOME/Cpp/
cd $HOME/Cpp
gh repo clone Utils
cd ..
gh repo clone Rust

gh repo clone timelog
