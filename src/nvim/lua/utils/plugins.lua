Plugs = {
    -- Basic Plugins {{{
    "folke/which-key.nvim",
    "BurntSushi/ripgrep",
    "norcalli/nvim-colorizer.lua",
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
    {
        "exafunction/codeium.nvim",
        opts = {},
        event = "BufEnter"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-calc",
            "FelipeLema/cmp-async-path",
            "petertriho/cmp-git"
            --
        }
    },
    --- }}}
    -- Snippet Plugins {{{

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        version = "v2.*",
        dependencies = "rafamadriz/friendly-snippets"
    },
    "saadparwaiz1/cmp_luasnip",
    -- "rafamadriz/friendly-snippets"
    -- "honza/vim-snippets",

    --- }}}
    -- Language Server Plugins {{{
    "dense-analysis/ale",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    {"folke/neodev.nvim", opts = {}},
    "folke/trouble.nvim",
    --- }}}
    -- General Language Plugins {{{
    "liuchengxu/vista.vim",
    "ludovicchabant/vim-gutentags",
    "numToStr/Comment.nvim",
    "kmonad/kmonad-vim",
    "danymat/neogen",
    "sbdchd/neoformat",
    "sheerun/vim-polyglot",
    -- TreeSitter Plugins {{{
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim",
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
    "echasnovski/mini.hipatterns",
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
    --- }}}
    -- Movement Plugins {{{
    "matze/vim-move",
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "s",
                mode = {"n", "x", "o"},
                function()
                    require("flash").jump()
                end,
                desc = "Flash"
            },
            {
                "S",
                mode = {"n", "o", "x"},
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash"
            },
            {
                "R",
                mode = {"o", "x"},
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search"
            },
            {
                "<c-s>",
                mode = {"c"},
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search"
            }
        }
    },
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
-- vim:foldmethod=marker foldlevel=0
