local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(
    function(use)
        -- Plugins {{{
        -- Packer can manage itself {{{
        use "wbthomason/packer.nvim"
        --- }}}
        -- Telescope Plugins {{{
        use "BurntSushi/ripgrep"
        use "nvim-telescope/telescope-symbols.nvim"
        use "nvim-telescope/telescope.nvim"
        use "p00f/nvim-ts-rainbow"
        --- }}}
        -- Completion Plugins {{{
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-path"
        use "hrsh7th/nvim-cmp"
        use "tom-doerr/vim_codex"
        --- }}}
        -- Snippet Plugins {{{
        use "SirVer/ultisnips"
        use "honza/vim-snippets"
        use "quangnguyen30192/cmp-nvim-ultisnips"
        --- }}}
        -- Language Server Plugins {{{
        use "dense-analysis/ale"
        use "hrsh7th/cmp-nvim-lsp"
        use "kosayoda/nvim-lightbulb"
        use "neovim/nvim-lspconfig"
        use "williamboman/mason-lspconfig.nvim"
        use "williamboman/mason.nvim"
        --- }}}
        -- General Language Plugins {{{
        use "liuchengxu/vista.vim"
        use "ludovicchabant/vim-gutentags"
        use "nvim-treesitter/nvim-treesitter"
        use "numToStr/Comment.nvim"
        use "sbdchd/neoformat"
        use "sheerun/vim-polyglot"
        --- }}}
        -- Colorschemes and Appearance Plugins {{{
        use "lewis6991/gitsigns.nvim"
        use "stevearc/dressing.nvim"
        use "lukas-reineke/indent-blankline.nvim"
        -- Devicon Plugins {{{
        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        -- Colorschemes {{{
        use "folke/lsp-colors.nvim"
        use "navarasu/onedark.nvim"
        --- }}}
        --- }}}
        -- Statusline {{{
        use "nvim-lualine/lualine.nvim"
        --- }}}
        --- }}}
        -- Specific Language Plugins {{{
        -- HTML/CSS {{{
        use "ap/vim-css-color"
        use {"mattn/emmet-vim", {ft = "html"}}
        --- }}}
        -- Rust {{{
        use "Saecki/crates.nvim"
        use {"rust-lang/rust.vim", {ft = "rust"}}
        --- }}}
        -- Markdown {{{
        use(
            {
                "iamcco/markdown-preview.nvim",
                run = function()
                    vim.fn["mkdp#util#install"]()
                end
            }
        )
        --- }}}
        -- Other Dependencies Plugins {{{
        use "kevinhwang91/promise-async"
        use "mattn/webapi-vim"
        use "MunifTanjim/nui.nvim"
        use "nvim-lua/plenary.nvim"
        --- }}}
        --- }}}
        -- Movement Plugins {{{
        use "ggandor/leap.nvim"
        use "matze/vim-move"
        --- }}}
        -- FZF Plugins {{{
        use "junegunn/fzf"
        use "junegunn/fzf.vim"
        --- }}}
        -- Other Utility Plugins {{{
        use "Monster0506/mason-installer.nvim"
        use "antoinemadec/FixCursorHold.nvim"
        use "axieax/urlview.nvim"
        use "kyazdani42/nvim-tree.lua"
        use "romainl/vim-cool"
        use "simnalamburt/vim-mundo"
        use "tpope/vim-fugitive"
        use "tpope/vim-repeat"
        use "tpope/vim-surround"
        use "voldikss/vim-floaterm"
        use "wellle/targets.vim"
        use "windwp/nvim-autopairs"
        use "ziontee113/icon-picker.nvim"
        use "mong8se/actually.nvim"
        use "folke/which-key.nvim"
        use "kevinhwang91/nvim-ufo"
        --- }}}
        --- }}}
        if packer_bootstrap then
            require("packer").sync()
        end
    end
)
