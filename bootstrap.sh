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
            return 1

    fi
fi

# move dotfiles to dotfiles directory
for $file in `pwd`/*; do
  mv $file $HOME/dotfiles/$file
done



# install neovim, spacevim, starship
curl -sLf https://spacevim.org/install.sh | bash
curl -fsSL https://starship.rs/install.sh | bash
# test if nvim is installed
if test -f /usr/bin/nvim; then
    nvim +qa
else
    vim +qa
fi


mkdir $HOME/.SpaceVim/after/ftplugin -p
mkdir $HOME/.SpaceVim/ftdetect/ -p
# create symlinks
for file in $HOME/dotfiles/bash/*; do
  ln -s $file $HOME/$file
done
ln -s $HOME/dotfiles/vim/spell $HOME/.SpaceVim.d/spell
for file in $HOME/dotfiles/vim/autoload/*; do
  ln -s $file $HOME/.SpaceVim/autoload/$file
done
for file in $HOME/dotfiles/vim/colors/*; do
  ln -s $file $HOME/.SpaceVim/colors/$file
done
for file in $HOME/dotfiles/vim/syntax/*; do
  ln -s $file $HOME/.SpaceVim/syntax/$file
done
ln -s $HOME/dotfiles/vim/snippets $HOME/.SpaceVim/snippets
for file in $HOME/dotfiles/vim/after/ftplugin; do
  ln -s $file $HOME/.vim/after/ftplugin/$file
done
for file in $HOME/dotfiles/vim/ftdetect; do
  ln -s $file $HOME/.vim/ftdetect/$file
done
ln -s $HOME/dotfiles/vim/init.toml $HOME/.SpaceVim.d/init.toml
ln -s $HOME/dotfiles/starship.toml $HOME/.config/starship.toml
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vim/vimrc

