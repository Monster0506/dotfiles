#!/usr/bin/env lua
HOME = os.getenv("HOME")
-- print(HOME)
-- vim.gs (global variables) {{{
local vimg = {
    airline_right_alt_sep = "",
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
    chadtree_settings = {
        view = {
            open_direction = "right"
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
--- }}}
-- General Language Plugins {{{
-- Treesitter Plugins {{{
Plug "nvim-treesitter/nvim-treesitter"
--- }}}
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
--- }}}
-- Statusline {{{
Plug "vim-airline/vim-airline"
--- }}}
Plug "lewis6991/gitsigns.nvim"
Plug "stevearc/dressing.nvim"
Plug "thaerkh/vim-indentguides"
--- }}}
-- Specific Language Plugins {{{
-- HTML/CSS {{{
Plug "ap/vim-css-color"
Plug "mattn/emmet-vim"
--- }}}
-- Rust {{{
Plug "Saecki/crates.nvim"
Plug "rust-lang/rust.vim"
--- }}}
-- Markdown {{{
Plug "ellisonleao/glow.nvim"
--- }}}
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
Plug "ZhiyuanLck/smart-pairs"
Plug "ms-jpq/chadtree"
Plug "romainl/vim-cool"
Plug "tpope/vim-repeat"
Plug "tpope/vim-surround"
Plug "voldikss/vim-floaterm"
Plug "wellle/targets.vim"
Plug "simnalamburt/vim-mundo"
--- }}}
vim.call("plug#end")
--- }}}

-- Local variables {{{
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- local cmp = require "cmp"
--- }}}

-- Setup Functions {{{
require("gitsigns").setup()
require("nvim-lsp-installer").setup()
require("pairs"):setup()
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
    {src = "bc"},
    {src = "figlet"}
}
--- }}}

-- vim.opts {{{
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

-- vim settings and keybindings {{{
vim.cmd(
    [[
" Misc Settings {{{
" Keymappings {{{
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/
" }}}
syntax on
colorscheme edge
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
vim.api.nvim_create_user_command("W", ":w", {})
vim.api.nvim_create_user_command("WQ", ":wq", {})
vim.api.nvim_create_user_command("WQa", ":wqa", {})
vim.api.nvim_create_user_command("Wq", ":wq", {})
vim.api.nvim_create_user_command("Wqa", ":wqa", {})
vim.api.nvim_create_user_command("Q :", "q", {})
vim.api.nvim_create_user_command("Noh", ":noh", {})
vim.api.nvim_create_user_command("Nog", ":noh", {})
--- }}}

-- Autocmds {{{
-- Fold Init.lua when sourced, read, or saved with markers {{{
vim.api.nvim_create_autocmd(
    {"BufRead", "BufWrite", "SourceCmd", "BufEnter"},
    {
        pattern = vim.fn.expand "$MYVIMRC",
        command = "set foldmethod=marker"
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
        command = "silent Neoformat | silent undojoin"
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

-- keybindings {{{
-- Window Resizing/Movement {{{
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
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
keymap("n", "j", "gjzz", opts)
keymap("v", "j", "gjzz", opts)
keymap("n", "k", "gkzz", opts)
keymap("v", "k", "gkzz", opts)
--- }}}
-- Miscellaneous Mappings {{{
keymap("n", "<C-a>", "ggVG", opts)
keymap("i", ":check:", "✓", opts)
keymap("n", "+", "<C-a>", opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<C-t>", "<cmd>CHADopen<CR>", opts)
keymap("n", "<leader>t", "<cmd>FloatermToggle<CR>", opts)
keymap("n", "<space>r", "<cmd>FloatermNew ranger<CR>", opts)
keymap("n", "<F2>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
keymap("n", "<Space>t", "<cmd>Vista nvim_lsp<CR>", opts)
keymap("n", "<Space>m", "<cmd>MundoToggle<CR>", opts)
keymap("n", "<leader>l", ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>", opts)
keymap("x", ">", ">gv", opts)
keymap("x", ">", ">gv", opts)

--- }}}
-- Telescope Mappings {{{
keymap("n", "<leader>h", "<cmd>History<CR>", opts)
keymap("n", "<leader>h/", "<cmd>History/<CR>", opts)
keymap("n", "<leader>h:", "<cmd>History:<CR>", opts)
keymap("n", "<leader>m", "<cmd>Maps<CR>", opts)
keymap("n", "<leader>b", "<cmd>Buffers<CR>", opts)
keymap("n", "<leader>w", "<cmd>Windows<CR>", opts)

--- }}}
-- LSP Mappings {{{
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
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

-- Rust Folding {{{
-- See https://github.com/narodnik/rust-fold-functions.vim/blob/master/rust-fold.vim
vim.cmd(
    [[
function! MakeRustFuncDefs()
    let b:RustFuncDefs = []

    let lnum = 1
    while lnum <= line('$')
        let current_line = getline(lnum)
        if match(current_line, '^ *\(pub \)\?fn') > -1
            call AddRustFunc(lnum)
        endif

        let lnum += 1
    endwhile
endfunction

function! AddRustFunc(lnum)
    let save_pos = getpos('.')
    call setpos('.', [0, a:lnum, 1, 0])

    call search('{')
    let start_lnum = line('.')

    let end_lnum = searchpair('{', '', '}', 'n')
    if end_lnum < 1
        call setpos('.', save_pos)
        return
    endif

    call add(b:RustFuncDefs, [start_lnum, end_lnum]);
    call setpos('.', save_pos)
endfunction

function! RustFold()
    if !exists("b:RustFuncDefs")
        call MakeRustFuncDefs()
    endif

    for [start_lnum, end_lnum] in b:RustFuncDefs
        if start_lnum > v:lnum
            return 0
        endif

        if v:lnum == start_lnum + 1
            return ">1"
        elseif v:lnum == end_lnum
            return "<1"
        elseif v:lnum > start_lnum && v:lnum < end_lnum
            return "="
        endif
    endfor
endfunction

autocmd FileType rust setlocal foldmethod=expr foldexpr=RustFold()
    ]]
)
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

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set(
        "n",
        "<space>wl",
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
--- }}}
