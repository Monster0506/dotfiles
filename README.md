# Monster0506's Dotfiles

These are my personal dotfiles, configured to my tastes.
Feel free to copy, change, remove, or ignore these. 

## Installation

Please do not install these files without understanding what they do or 
what they are intended for. These files are mainly intended for setting up
a new installation. 

However, for ease of configuration, it does move current setup
files into \*.back, as not to overwrite them. 

To use, run `bash bootstrap.sh` in the directory in which you cloned 
or downloaded this repository.


### Follow-Up Steps
Yes, these could be in a bootstrap, but I am too lazy to do that.

- Install starship
    - `curl -sS https://starship.rs/install.sh | sh` 
- Install Python [(latest version)](https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz)
- Install Node
    - `curl -fsSL https://fnm.vercel.app/install | bash`
    - `fnm install [Version Number (16.15.0)]`
 - `sudo apt install vim neovim vim-gtk3 fzf i3 -y`
 - Install ruby from [here](https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.2.tar.gz)
 - Install vim-plug
     - `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'` 
 - Install COC extentions via coc-marketplace
     - coc-pyright
     - coc-snippets
     - coc-lua
 - Install useful python tools
     - `python3 -m pip install setuptools`
     - `pip3 install black`
     - `sudo apt install flake8 pylint -y`

## Contents

I keep a pretty minimal configuration, but if I find something that I like, I
often add it to my dotfiles for later usage.

As a shell, I use bash with the [starship](https://starship.rs) prompt, and,
as such, there is a starship configuration file there. I don't often change those settings.


### ViM Plugins

May be out-dated

 - [preservim/nerdtree](https://preservim/nerdtree)
 - [morhetz/gruvbox](https://github.com/morhetz/gruvbox)
 - [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
 - [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)
 - [sbdchd/neoformat](https://github.com/sbdchd/neoformat)
 - [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)
 - [preservim/nerdcommenter](https://github.com/preservim/nerdcommenter)
 - [tpope/vim-repeat](https://github.com/tpope/vim-repeat)
 - [tpope/vim-surround](https://github.com/tpope/vim-surround)
 - [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)
 - [mattn/emmet-vim](https://github.com/mattn/emmet-vim)
 - [ap/vim-css-color](https://github.com/ap/vim-css-color)
 - [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
 - [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
 - [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot)
 - [vim-syntastic/syntastic](https://github.com/vim-syntastic/syntastic)
