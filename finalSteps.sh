#!/usr/bin/bash 
sudo ln -s $HOME/$INSTALLDIR/home/.profile $HOME/.profile
mkdir Cpp/
cd Cpp
gh repo clone Utils
cd ..
gh repo clone Rust

