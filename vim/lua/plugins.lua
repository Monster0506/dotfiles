local M = {}
function M.setup()
    local Plug = vim.fn["plug#"]
    vim.call("plug#begin")
    -- Telescope Plugins {{{
    Plug "nvim-telescope/telescope.nvim"
    Plug "BurntSushi/ripgrep"
    Plug "nvim-telescope/telescope-symbols.nvim"
    Plug "p00f/nvim-ts-rainbow"
    Plug "sudormrfbin/cheatsheet.nvim"
    --- }}}
    -- Completion Plugins {{{
    Plug("ms-jpq/coq_nvim", {["branch"] = "coq"})
    Plug("ms-jpq/coq.artifacts", {["branch"] = "artifacts"})
    Plug("ms-jpq/coq.thirdparty", {["branch"] = "3p"})
    Plug "tom-doerr/vim_codex"
    --- }}}
    -- Language Server Plugins {{{
    Plug "neovim/nvim-lspconfig"
    Plug "williamboman/nvim-lsp-installer"
    Plug "dense-analysis/ale"
    Plug "kosayoda/nvim-lightbulb"
    --- }}}
    -- General Language Plugins {{{
    Plug "nvim-treesitter/nvim-treesitter"
    Plug "preservim/nerdcommenter"
    Plug "liuchengxu/vista.vim"
    Plug "ludovicchabant/vim-gutentags"
    Plug "sbdchd/neoformat"
    Plug "sheerun/vim-polyglot"
    Plug "vim-syntastic/syntastic"
    --- }}}
    -- Colorschemes and Appearance Plugins {{{
    -- Devicon Plugins {{{
    Plug "kyazdani42/nvim-web-devicons"
    Plug "ryanoasis/vim-devicons"
    --- }}}
    -- Colorschemes {{{
    Plug "folke/lsp-colors.nvim"
    Plug "morhetz/gruvbox"
    Plug "sainnhe/edge"
    Plug "sjl/badwolf"
    Plug "navarasu/onedark.nvim"
    --- }}}
    -- Statusline {{{
    Plug "nvim-lualine/lualine.nvim"
    --- }}}
    Plug "lewis6991/gitsigns.nvim"
    Plug "stevearc/dressing.nvim"
    Plug "lukas-reineke/indent-blankline.nvim"
    --- }}}
    -- Specific Language Plugins {{{
    -- HTML/CSS {{{
    Plug "ap/vim-css-color"
    Plug("mattn/emmet-vim", {["for"] = "html"})
    --- }}}
    -- Rust {{{
    Plug("Saecki/crates.nvim")
    Plug("rust-lang/rust.vim", {["for"] = "rust"})
    --- }}}
    -- Markdown {{{
    Plug "ellisonleao/glow.nvim"
    --- }}}
    -- Clojure {{{
    Plug("guns/vim-sexp", {["for"] = "clojure"})
    --- }}}
    -- Aptfile {{{
    Plug "Monster0506/vim-aptfile"
    -- }}}
    --- }}}
    -- Other Dependencies Plugins {{{
    Plug "kevinhwang91/promise-async"
    Plug "mattn/webapi-vim"
    Plug "MunifTanjim/nui.nvim"
    Plug "nvim-lua/plenary.nvim"
    --- }}}
    -- Movement Plugins {{{
    Plug "easymotion/vim-easymotion"
    Plug "matze/vim-move"
    --- }}}
    -- FZF Plugins {{{
    Plug "junegunn/fzf"
    Plug "junegunn/fzf.vim"
    --- }}}
    -- Other Utility Plugins {{{
    Plug "antoinemadec/FixCursorHold.nvim"
    Plug "axieax/urlview.nvim"
    Plug "windwp/nvim-autopairs"
    Plug "kyazdani42/nvim-tree.lua"
    Plug "romainl/vim-cool"
    Plug "tpope/vim-repeat"
    Plug "tpope/vim-fugitive"
    Plug "tpope/vim-surround"
    Plug "voldikss/vim-floaterm"
    Plug "wellle/targets.vim"
    Plug "simnalamburt/vim-mundo"
    --- }}}
    vim.call("plug#end")
end

return M
