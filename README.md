# Monster0506's Dotfiles

These are my personal dotfiles, configured to my tastes.
Feel free to copy, change, remove, or ignore these.

## Installation

Please do not install these files without understanding what they do or
what they are intended for. These files are mainly intended for setting up
a new installation.

To use, run `./script/bootstrap` in the directory in which you cloned
or downloaded this repository.

Alternatively, if [`make`](https://www.gnu.org/software/make/) is installed on
your system, you can run `make install` or `make generate`.

On average, this takes around 5 minutes to completely install on a fresh
Arch machine.

If you want to sync your files back to the dotfiles repository, you can run
`./script/sync` or `make sync` to copy the files in `~/.cfg` back to this repo.

An out-of date installation script for Debian can be found on the `debian` branch (`git switch debian`).

## Follow-up Steps

Make sure to `source ~/.bashrc`.
The file `finalSteps` is just for me, and contains some personal configuration.

## Contents

As a shell, I use bash with the [starship](https://starship.rs) prompt, and,
as such, there is a starship configuration file there. I don't often change
those settings.

I use [ranger](https://ranger.github.io/) as a file manager, and there is also a
ranger config file with some pretty basic configurations

### ViM/Neovim Plugins

This may not be completely up-to-date, so please view the [plugins](src/vim/lua/plugins.lua)
file for completeness.

- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)

#### Telescope Plugins

- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [nvim-telescope/telescope-symbols.nvim](https://github.com/nvim-telescope/telescope-symbols.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [p00f/nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)

#### Completion Plugins

- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [tom-doerr/vim_codex](https://github.com/tom-doerr/vim_codex)

#### Snippet Plugins

- [SirVer/ultisnips](https://github.com/SirVer/ultisnips)
- [honza/vim-snippets](https://github.com/honza/vim-snippets)
- [quangnguyen30192/cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips)

#### Language Server Plugins

- [dense-analysis/ale](https://github.com/dense-analysis/ale)
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)

#### General Language Plugins

- [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
- [ludovicchabant/vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [sbdchd/neoformat](https://github.com/sbdchd/neoformat)
- [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot)

#### Colorschemes and Appearance Plugins

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

##### Devicon Plugins

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

##### Colorschemes

- [folke/lsp-colors.nvim](https://github.com/folke/lsp-colors.nvim)
- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)

##### Statusline

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

#### Specific Language Plugins

##### HTML/CSS

- [ap/vim-css-color](https://github.com/ap/vim-css-color)
- [mattn/emmet-vim](https://github.com/mattn/emmet-vim)

##### Rust

- [Saecki/crates.nvim](https://github.com/Saecki/crates.nvim)
- [rust-lang/rust.vim](https://github.com/rust-lang/rust.vim)

##### Markdown

- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

#### Other Dependencies Plugins

- [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async)
- [mattn/webapi-vim](https://github.com/mattn/webapi-vim)
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-lua/plenary.nvim]()(https://github.com/nvim-lua/plenary.nvim)

#### Movement Plugins

- [ggandor/leap.nvim](https://github.com/ggandor/leap.nvim)
- [matze/vim-move](https://github.com/matze/vim-move)

#### FZF Plugins

- [junegunn/fzf](https://github.com/junegunn/fzf)
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)

#### Other Utility Plugins

- [antoinemadec/FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)
- [axieax/urlview.nvim](https://github.com/axieax/urlview.nvim)
- [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [romainl/vim-cool](https://github.com/romainl/vim-cool)
- [simnalamburt/vim-mundo](https://github.com/simnalamburt/vim-mundo)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [tpope/vim-repeat](https://github.com/tpope/vim-repeat)
- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [wellle/targets.vim](https://github.com/wellle/targets.vim)
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [ziontee113/icon-picker.nvim](https://github.com/ziontee113/icon-picker.nvim)
- [mong8se/actually.nvim](https://github.com/mong8se/actually.nvim)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)

