# Monster0506's Dotfiles

These are my personal dotfiles, configured to my tastes.
Feel free to copy, change, remove, or ignore these. 

## Installation

Please do not install these files without understanding what they do or 
what they are intended for. These files are mainly intended for setting up
a new installation. 

To use, run `./bootstrap.sh` in the directory in which you cloned 
or downloaded this repository.

On average, this takes around 12 minutes to completely install on a fresh Debian machine.
The longest part of the install is the install of [libboost](https://www.boost.org/), which takes around 2-4 minutes. 
You can remove and modify this yourself simply by removing or commenting out the relevant lines in the [packages](packages) file.

## Follow-up Steps

Make sure to source ~/.bashrc `. ~/.bashrc`

## Contents

As a shell, I use bash with the [starship](https://starship.rs) prompt, and,
as such, there is a starship configuration file there. I don't often change those settings.

I use [ranger](https://ranger.github.io/) as a file manager, and there is also a ranger config file there with some
pretty basic configurations


### ViM Plugins

## Telescope Plugins 

- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [fannheyward/telescope-coc.nvim](https://github.com/fannheyward/telescope-coc.nvim)
- [nvim-telescope/telescope-symbols.nvim](https://github.com/nvim-telescope/telescope-symbols.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [p00f/nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
- [sudormrfbin/cheatsheet.nvim](https://github.com/sudormrfbin/cheatsheet.nvim)

## Completion Plugins 

- [ms-jpq/coq.nvim](https://github.com/ms-jsp/coq.nvim)
- [ms-jpq/coq.artifacts](https://github.com/ms-jpq/coq.artifacts)
- [ms-jpq/coq.thirdparty](https://github.com/ms-jpq/coq.thirdparty)
- [tom-doerr/vim_codex](https://github.com/tom-doerr/vim_codex)

## Language Server Plugins 

- [dense-analysis/ale](https://github.com/dense-analysis/ale)

## General Language Plugins 

- [preservim/nerdcommenter](https://github.com/preservim/nerdcommenter)
- [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
- [sbdchd/neoformat](https://github.com/sbdchd/neoformat)
- [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot)
- [vim-syntastic/syntastic](https://github.com/vim-syntastic/syntastic)

### Treesitter Plugins

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Colorschemes and Appearance Plugins 

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [thaerkh/vim-indentguides](https://github.com/thaerkh/vim-indentguides)

### Devicon Plugins 

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

### Colorschemes 

- [folke/lsp-colors.nvim](https://github.com/folke/lsp-colors.nvim)
- [morhetz/gruvbox](https://github.com/morhetz/gruvbox)
- [sainnhe/edge](https://github.com/sainnhe/edge)
- [sjl/badwolf](https://github.com/sjl/badwolf)

### Statusline

- [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)

## Specific Language Plugins 

### HTML/CSS 

- [ap/vim-css-color](https://github.com/ap/vim-css-color)
- [mattn/emmet-vim](https://github.com/mattn/emmet-vim)

### Rust 

- [Saecki/crates.nvim](https://github.com/Saecki/crates.nvim)
- [rust-lang/rust.vim](https://github.com/rust-lang/rust.vim)

### Markdown 

- [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim)

## Other Dependencies Plugins 

- [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async)
- [mattn/webapi-vim](https://github.com/mattn/webapi-vim)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Movement Plugins 

- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)
- [matze/vim-move](https://github.com/matze/vim-move)

## FZF Plugins 

- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [junegunn/fzf](https://github.com/junegunn/fzf)

## Other Utility Plugins 

- [antoinemadec/FixCursorHold.vim](https://github.com/antoinemadec/FixCursorHold.nvim)
- [axieax/urlview.nvim](https://github.com/axieax/urlview.nvim)
- [zhiyuanlck/smart-pairs](https://github.com/zhiyuanlck/smart-pairs)
- [ms-jpq/chadtree](https://github.com/ms-jpq/chadtree)
- [preservim/tagbar](https://github.com/preservim/tagbar)
- [romainl/vim-cool](https://github.com/romainl/vim-cool)
- [tpope/vim-repeat](https://github.com/tpope/vim-repeat)
- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [voldikss/vim-floaterm](https://github.com/vim-floaterm)
- [wellle/targets.vim](https://github.com/wellle/targets.vim)
