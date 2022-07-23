#!/usr/bin/env sh
DEST=$(basename $(sed -n 1p $HOME/.dotfiles))
FILES=$(basename $(sed -n 2p $HOME/.dotfiles))

for file in ~/$FILES/*; do
	cp $file ~/$DEST/src/ -r
	echo $file
done
