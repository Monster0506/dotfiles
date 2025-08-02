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

This may not be completely up-to-date, so please view the [plugins](src/nvim/lua/config/plugins/plugins.lua)
file for completeness.

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim.git)

#### Utility Plugins
- [xzbdmw/colorful-menu.nvim](https://github.com/xzbdmw/colorful-menu.nvim)
- [MagicDuck/grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)
- [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
- [Dan7h3x/signup.nvim](https://github.com/Dan7h3x/signup.nvim)
- [SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [echasnovski/mini.clue](https://github.com/echasnovski/mini.clue)
- [echasnovski/mini.icons](https://github.com/echasnovski/mini.icons)

#### Telescope Plugins
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)

#### Completion Plugins
- [saghen/blink.cmp](https://github.com/saghen/blink.cmp)
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

#### Language Server Plugins
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim)
- [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)

#### TreeSitter Plugins
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

#### Colorschemes and Appearance Plugins
- [catppuccin/nvim](https://github.com/catppuccin/nvim)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
