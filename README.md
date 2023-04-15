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

This may not be completely up-to-date, so please view the [plugins](src/nvim/lua/utils/lazy.lua)
file for completeness.

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim.git)

#### Utility Plugins 
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [Monster0506/mason-installer.nvim](https://github.com/Monster0506/mason-installer.nvim)
- [antoinemadec/FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)
- [axieax/urlview.nvim](https://github.com/axieax/urlview.nvim)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [kevinhwang92/nvim-ufo](https://github.com/kevinhwang92/nvim-ufo)
- [kyazdani43/nvim-tree.lua](https://github.com/kyazdani43/nvim-tree.lua)
- [mong9se/actually.nvim](https://github.com/mong9se/actually.nvim)
- [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [romainl/vim-cool](https://github.com/romainl/vim-cool)
- [simnalamburt/vim-mundo](https://github.com/simnalamburt/vim-mundo)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [tpope/vim-repeat](https://github.com/tpope/vim-repeat)
- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [wellle/targets.vim](https://github.com/wellle/targets.vim)
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [ziontee114/icon-picker.nvim](https://github.com/ziontee114/icon-picker.nvim)

#### Telescope Plugins
- [debugloop/telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)
- [nvim-telescope/telescope-symbols.nvim](https://github.com/nvim-telescope/telescope-symbols.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

#### Completion PLugins
- [FelipeLema/cmp-async-path](https://github.com/FelipeLema/cmp-async-path)
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [hrsh7th/cmp-calc](https://github.com/hrsh7th/cmp-calc)
- [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [lukas-reineke/cmp-rg](https://github.com/lukas-reineke/cmp-rg)
- [petertriho/cmp-git](https://github.com/petertriho/cmp-git)
- [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)

#### Snippet Plugins
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [honza/vim-snippets](https://github.com/honza/vim-snippets)
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

#### Language Server Plugins 
- [dense-analysis/ale](https://github.com/dense-analysis/ale)
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)

#### General Language Plugins 
- [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
- [ludovicchabant/vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [sbdchd/neoformat](https://github.com/sbdchd/neoformat)
- [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot)

#### TreeSitter Plugins 
- [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [p00f/nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)

#### Colorschemes and Appearance Plugins 
- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [luukvbaal/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim)
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)

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
- [Saecki/crates.nvim,](https://github.com/Saecki/crates.nvim,)
- [rust-lang/rust.vim](https://github.com/rust-lang/rust.vim)

##### Markdown 
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

#### Other Dependencies Plugins ,
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async)
- [mattn/webapi-vim](https://github.com/mattn/webapi-vim)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

#### Movement Plugins 
- [ggandor/leap.nvim](https://github.com/ggandor/leap.nvim)
- [matze/vim-move](https://github.com/matze/vim-move)

#### FZF Plugins 
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [junegunn/fzf](https://github.com/junegunn/fzf)

