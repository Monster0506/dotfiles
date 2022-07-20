#!/usr/bin/env lua
HOME = os.getenv("HOME")
-- print(HOME)

-- Global Vim Variables (vim.g) {{{
local vimg = {
    airline_right_alt_sep = "",
    indent_blankline_show_current_context = true,
    indent_blankline_show_current_context_start = true,
    NERDSpaceDelims = 1,
    airline_left_sep = "",
    coq_settings = {
        clients = {
            tabnine = {
                enabled = true
            }
        },
        auto_start = "shut-up",
        display = {
            ghost_text = {
                context = {"    < ", " >"},
                highlight_group = "Cyan"
            },
            pum = {
                ellipsis = ". . .",
                kind_context = {" {", "}"}
            }
        }
    },
    airline_left_alt_sep = "",
    airline_right_sep = "",
    ale_disable_lsp = 1,
    ale_sign_warning = "",
    netrw_browsex_viewer = "xdg-open",
    edge_style = "neon",
    floaterm_position = "topleft",
    floaterm_autoclose = 2,
    floaterm_opener = "vsplit"
}

for k, v in pairs(vimg) do
    vim.g[k] = v
    -- print(k, v)
end

--- }}}

-- Plugins {{{
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
Plug "vim-airline/vim-airline"
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
Plug "tpope/vim-surround"
Plug "voldikss/vim-floaterm"
Plug "wellle/targets.vim"
Plug "simnalamburt/vim-mundo"
--- }}}
vim.call("plug#end")
--- }}}

-- Local and Global Lua Variables {{{
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
local capabilities = vim.lsp.protocol.make_client_capabilities()
--- }}}

-- Setup Functions {{{
require("gitsigns").setup()
require("nvim-lsp-installer").setup()
require("nvim-autopairs").setup {}
require("crates").setup {
    src = {
        coq = {
            enabled = true,
            name = "crates.nvim"
        }
    }
}
require("coq_3p") {
    {src = "nvimlua"},
    {src = "bc", short_name = "MATH", precision = 6},
    {src = "figlet"}
}
require("nvim-lightbulb").setup(
    {
        autocmd = {
            enabled = true
        },
        sign = {
            enabled = true
        }
    }
)
require("nvim-tree").setup(
    {
        view = {
            side = "right",
            mappings = {
                list = {
                    {key = "<C-t>", action = "close"}
                }
            }
        },
        filters = {
            dotfiles = false
        }
    }
)

--- }}}

-- Options (vim.opt) {{{
vim.cmd([[set termguicolors]])
local vimopts = {
    background = "dark",
    relativenumber = true,
    number = true,
    undofile = true,
    smartcase = true,
    mouse = "a",
    guifont = "FiraCode Nerd Font:h15",
    ignorecase = true,
    expandtab = true,
    backup = false,
    swapfile = false,
    wildignore = "*.docx,*.pdf,*.exe,*.mcmeta,*.xlsx",
    colorcolumn = "80",
    foldmethod = "syntax",
    concealcursor = "nc",
    list = true
}
-- set vim options
for k, v in pairs(vimopts) do
    vim.opt[k] = v
end
vim.opt.listchars:append("eol:↴")
--- }}}

-- Misc Vim Settings {{{
vim.cmd(
    [[
" Misc Settings {{{
" Keymappings {{{
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/
" }}}
syntax on
colorscheme onedark
" }}}
" NEXT OBJECT MAPPING {{{
" https://gist.github.com/AndrewRadev/1171559
onoremap an :<c-u>call NextTextObject('a')<cr>
xnoremap an :<c-u>call NextTextObject('a')<cr>
onoremap in :<c-u>call NextTextObject('i')<cr>
xnoremap in :<c-u>call NextTextObject('i')<cr>

function! NextTextObject(motion)
  echo
  let c = nr2char(getchar())
  exe "normal! f".c."v".a:motion.c
endfunction
" }}}
        ]]
)
--- }}}

-- Commands {{{
vim.api.nvim_create_user_command("W", ":w", {bang = true})
vim.api.nvim_create_user_command("WQ", ":wq", {bang = true})
vim.api.nvim_create_user_command("WQa", ":wqa", {bang = true})
vim.api.nvim_create_user_command("Wq", ":wq", {bang = true})
vim.api.nvim_create_user_command("Wqa", ":wqa", {bang = true})
vim.api.nvim_create_user_command("Q :", "q", {bang = true})
vim.api.nvim_create_user_command("Noh", ":noh", {bang = true})
vim.api.nvim_create_user_command("Nog", ":noh", {bang = true})
--- }}}

-- Autocmds {{{
-- Fold Init.lua when sourced, read, or saved with markers {{{
vim.api.nvim_create_autocmd(
    {"BufRead", "BufWrite", "SourceCmd", "BufEnter"},
    {
        pattern = vim.fn.expand "$MYVIMRC",
        command = "set foldmethod=marker "
    }
)
--- }}}
-- Format on save {{{
vim.api.nvim_create_autocmd(
    {
        "BufWritePre"
    },
    {
        pattern = "*",
        command = "silent Neoformat | silent! undojoin"
    }
)
--- }}}
-- Highlight line in normal mode {{{
-- Highlight {{{
vim.api.nvim_create_autocmd(
    {
        "VimEnter",
        "InsertLeave",
        "WinEnter"
    },
    {
        pattern = "*",
        command = "set cursorline"
    }
)
--- }}}
-- Remove cursorline {{{
vim.api.nvim_create_autocmd(
    {
        "VimLeave",
        "InsertEnter",
        "WinLeave"
    },
    {
        pattern = "*",
        command = "set nocursorline"
    }
)
-- }}}
--- }}}
-- Make Vim Create Parent Directories on Save {{{
-- See https://github.com/jghauser/mkdir.nvim/blob/main/lua/mkdir.lua

local luafunc = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

vim.api.nvim_create_autocmd(
    {
        "BufWritePre"
    },
    {
        pattern = "*",
        callback = luafunc
    }
)

--- }}}
--- }}}

-- Keybindings {{{
-- Window Resizing/Movement {{{
-- Resize splits
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
-- Change split orientation
keymap("n", ",v", "<C-w>t<C-w>H", opts)
keymap("n", ",h", "<C-w>t<C-w>K", opts)
keymap("n", "<M-Right>", "<cmd>tabnext<CR>", opts)
keymap("n", "<M-Left>", "<cmd>tabprevious<CR>", opts)
--- }}}
-- FZF {{{
keymap("n", "<C-p>", "<cmd>Files<CR>", opts)
keymap("n", "<leader><C-p>", "<cmd>Commands<CR>", opts)
--- }}}
-- Bracket expansion {{{
keymap("i", "(<CR>", "(<CR>)<Esc>O", opts)
keymap("i", "(;", "(<CR>);<Esc>O", opts)
keymap("i", "(,", "(<CR>),<Esc>O", opts)
keymap("i", "{<CR>", "{<CR>}<Esc>O", opts)
keymap("i", "{;", "{<CR>};<Esc>O", opts)
keymap("i", "{,", "{<CR>},<Esc>O", opts)
keymap("i", "[<CR>", "[<CR>]<Esc>O", opts)
keymap("i", "[;", "[<CR>];<Esc>O", opts)
keymap("i", "[,", "[<CR>],<Esc>O", opts)
--- }}}
-- Center Text on the Screen {{{
local remapList = {"p", "P", "<CR>", "gg", "H", "M", "L", "n", "N", "%"}
for k in pairs(remapList) do
    keymap("n", remapList[k], remapList[k] .. "zz", opts)
    keymap("v", remapList[k], remapList[k] .. "zz", opts)
end
keymap("n", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
keymap("n", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})
keymap("v", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
keymap("v", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})

--- }}}
-- Miscellaneous Mappings {{{
keymap("n", "<C-a>", "ggVG", opts)
keymap("i", ":check:", "✓", opts)
keymap("n", "+", "<C-a>", opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<leader>t", "<cmd>FloatermToggle<CR>", opts)
keymap("n", "<space>r", "<cmd>FloatermNew ranger<CR>", opts)
keymap("n", "<F2>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
keymap("n", "<Space>t", "<cmd>Vista nvim_lsp<CR>", opts)
keymap("n", "<Space>u", "<cmd>MundoToggle<CR>", opts)
keymap("n", "<leader>l", ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>", opts)
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)
keymap("c", "cd.", "lcd %:p:h<CR>", opts)
keymap("c", "cwd", "lcd %:p:h<CR>", opts)

--- }}}
-- Telescope Mappings {{{
keymap("n", "<space>h", "<cmd>History<CR>", opts)
keymap("n", "<space>h/", "<cmd>History/<CR>", opts)
keymap("n", "<space>h:", "<cmd>History:<CR>", opts)
keymap("n", "<space>m", "<cmd>Maps<CR>", opts)
keymap("n", "<space>b", "<cmd>Buffers<CR>", opts)
keymap("n", "<space>w", "<cmd>Windows<CR>", opts)

--- }}}
-- LSP Mappings {{{
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
--- }}}
--- }}}

-- Treesitter Settings {{{
require "nvim-treesitter.configs".setup {
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    },
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "python",
        "cpp",
        "typescript",
        "javascript",
        "bash",
        "markdown",
        "clojure",
        "regex",
        "toml"
    },
    highlight = {
        enable = true
    },
    matchup = {
        enable = true
    }
}
--- }}}

-- LSP {{{
-- On Attach {{{
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings. See `:help vim.lsp.*` for documentation on any of the below
    -- functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set(
        "n",
        "<leader>wl",
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        bufopts
    )
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
end
--- }}}
-- Servers {{{
local servers = {
    "sumneko_lua",
    "rust_analyzer",
    "pyright",
    "clojure_lsp",
    "tsserver",
    "eslint",
    "bashls",
    "marksman",
    "gopls",
    "html",
    "rome",
    "jsonls",
    "clangd"
}
for _, lsp in ipairs(servers) do
    require "lspconfig"[lsp].setup {
        require("coq").lsp_ensure_capabilities({}),
        on_attach = on_attach,
        capabilities = capabilities
    }
end

require("nvim-lsp-installer").setup(
    {
        automatic_installation = true,
        ensure_installed = servers
    }
)
--- }}}
--- }}
