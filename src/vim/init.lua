#!/usr/bin/env lua
HOME = os.getenv("HOME")
-- print(HOME)

-- Global Vim Variables (vim.g) {{{
local vimg = {
    indent_blankline_show_current_context = true,
    indent_blankline_show_current_context_start = true,
    NERDSpaceDelims = 1,
    netrw_browsex_viewer = "xdg-open",
    floaterm_position = "topleft",
    floaterm_autoclose = 2,
    floaterm_opener = "vsplit"
}

for k, v in pairs(vimg) do
    vim.g[k] = v
end

--- }}}

-- Local and Global Lua Variables {{{
--- }}}

-- Setup Functions {{{
require("plugins").setup() -- lua/plugins.lua
require("autocmds").setup() -- lua/autocmds.lua
require("keybindings").setup() -- lua/keybindings.lua keymappings keymaps
require("options").setup() -- lua/options.lua
require("evil").setup() -- lua/evil.lua
require("commands").setup() -- lua/commands.lua
require("setup").run() -- lua/setup.lua
require("nvim_cmp").setup() -- lua/nvim_cmp.lua
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
    vim.keymap.set("n", "K", ShowDocumentation, bufopts)
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
function ShowDocumentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({"vim", "help"}, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({"man"}, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif vim.fn.expand("%:t") == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("mason-lspconfig").setup(
    {
        ensure_installed = servers
    }
)
for _, lsp in ipairs(servers) do
    require "lspconfig"[lsp].setup {
        -- require("coq").lsp_ensure_capabilities({}),
        on_attach = on_attach,
        capabilities = capabilities
    }
end

--- }}}
--- }}
