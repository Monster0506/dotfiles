Plugs = {
    "folke/which-key.nvim",
    "BurntSushi/ripgrep",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope.nvim",
            "debugloop/telescope-undo.nvim"
        }
    },
    --- }}}
    -- Completion Plugins {{{
    "zbirenbaum/copilot.lua",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "lukas-reineke/cmp-rg",
            "hrsh7th/cmp-calc",
            "FelipeLema/cmp-async-path",
            "petertriho/cmp-git"
            --
        }
    },
    --- }}}
    -- Snippet Plugins {{{
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "honza/vim-snippets",
    --- }}}
    -- Language Server Plugins {{{
    "dense-analysis/ale",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "folke/trouble.nvim",
    --- }}}
    -- General Language Plugins {{{
    "liuchengxu/vista.vim",
    "ludovicchabant/vim-gutentags",
    "numToStr/Comment.nvim",
    "sbdchd/neoformat",
    "sheerun/vim-polyglot",
    -- TreeSitter Plugins {{{
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        dependencies = {
            "p00f/nvim-ts-rainbow",
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-context"
        }
    },
    --- }}}
    --- }}}
    -- Colorschemes and Appearance Plugins {{{
    "folke/tokyonight.nvim",
    "lewis6991/gitsigns.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "luukvbaal/statuscol.nvim",
    "rcarriga/nvim-notify",
    {"stevearc/dressing.nvim", event = "VeryLazy"},
    -- Devicon Plugins {{{
    {"kyazdani42/nvim-web-devicons", event = "VeryLazy"},
    {"ryanoasis/vim-devicons", event = "VeryLazy"},
    -- Colorschemes {{{
    {"folke/lsp-colors.nvim", lazy = true},
    {"navarasu/onedark.nvim", lazy = true},
    --- }}}
    --- }}}
    -- Statusline {{{
    "nvim-lualine/lualine.nvim",
    --- }}}
    --- }}}
    -- Specific Language Plugins {{{
    -- HTML/CSS {{{
    {"ap/vim-css-color", ft = "html"},
    {"mattn/emmet-vim", ft = "html"},
    --- }}}
    -- Rust {{{
    {"Saecki/crates.nvim", ft = "rust"},
    {"rust-lang/rust.vim", ft = "rust"},
    -- Markdown {{{
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = "markdown"
    },
    --- }}}
    -- Other Dependencies Plugins {{{,
    "kevinhwang91/promise-async",
    "mattn/webapi-vim",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    --- }}}
    --- }}}
    -- Movement Plugins {{{
    "ggandor/leap.nvim",
    "matze/vim-move",
    --- }}}
    -- FZF Plugins {{{
    "junegunn/fzf",
    "junegunn/fzf.vim",
    --- }}}
    -- Other Utility Plugins {{{
    "Monster0506/mason-installer.nvim",
    "alexghergh/nvim-tmux-navigation",
    "antoinemadec/FixCursorHold.nvim",
    "axieax/urlview.nvim",
    "folke/which-key.nvim",
    "kevinhwang91/nvim-ufo",
    "kyazdani42/nvim-tree.lua",
    "mong8se/actually.nvim",
    "romainl/vim-cool",
    "simnalamburt/vim-mundo",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "voldikss/vim-floaterm",
    "wellle/targets.vim",
    "windwp/nvim-autopairs",
    "ziontee113/icon-picker.nvim"
    --- }}}
    --- }}}
}

return Plugs
