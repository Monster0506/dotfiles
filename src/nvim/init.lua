---@diagnostic disable: undefined-global
HOME = os.getenv("HOME")

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

-- Setup Functions {{{
require("plugins") -- lua/plugins.lua
require("autocmds").setup() -- lua/autocmds.lua
require("keybindings").setup() -- lua/keybindings.lua keymappings keymaps
require("options").setup() -- lua/options.lua
require("evil").setup() -- lua/evil.lua
require("commands").setup() -- lua/commands.lua
require("setup").run() -- lua/setup.lua
require("nvim_cmp").setup() -- lua/nvim_cmp.lua
local wk = require("which-key")
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
    wk.register(
        {
            d = {vim.lsp.buf.definition, "Go to definition"},
            D = {vim.lsp.buf.declaration, "Go to declaration"},
            r = {vim.lsp.buf.references, "Go to references"},
            i = {vim.lsp.buf.implementation, "Go to implementation"}
        },
        {prefix = "g", buffer = bufnr}
    )

    wk.register(
        {
            w = {
                name = "workspace",
                a = {vim.lsp.buf.add_workspace_folder, "Add Workspace Folder"},
                r = {vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder"},
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    "View Workspace Folders"
                }
            },
            D = {vim.lsp.buf.type_definition, "Type Definition"},
            rn = {vim.lsp.buf.rename, "Rename"},
            ac = {vim.lsp.buf.code_action, "Code Action"}
        },
        {prefix = "<leader>"}
    )

    wk.register(
        {
            K = {ShowDocumentation, "Show Documentation"},
            ["<C-k>"] = {vim.lsp.buf.signature_help, "Signature Help"},
            ["<Space>"] = {vim.lsp.buf.format, "Format"}
        }
    )
end

function ShowDocumentation()
    local filetype = vim.bo.filetype
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        if vim.fn.expand("%:t") == "Cargo.toml" then
            require("crates").show_popup()
        elseif vim.tbl_contains({"vim", "help"}, filetype) then
            vim.cmd("h " .. vim.fn.expand("<cword>"))
        elseif vim.tbl_contains({"man"}, filetype) then
            vim.cmd("Man " .. vim.fn.expand("<cword>"))
        else
            vim.lsp.buf.hover()
        end
    end
end

--- }}}
-- Servers {{{
local servers = {
    "bashls",
    "clangd",
    "clojure_lsp",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "marksman",
    "pyright",
    "rome",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver"
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

for _, lsp in ipairs(servers) do
    require "lspconfig"[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

--- }}}
--- }}}

-- Mason {{{
require("mason-lspconfig").setup(
    {
        ensure_installed = servers
    }
)
require("mason-installer").setup(
    {
        ensure_installed = {
            "flake8",
            "shellcheck",
            "shfmt",
            "black"
        }
    }
)
--- }}}
