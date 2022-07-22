#!/usr/bin/env lua
HOME = os.getenv("HOME")
-- print(HOME)

-- Global Vim Variables (vim.g) {{{
local vimg = {
    indent_blankline_show_current_context = true,
    indent_blankline_show_current_context_start = true,
    NERDSpaceDelims = 1,
    coq_settings = {
        ["keymap.eval_snips"] = "<leader>j",
        clients = {
            tabnine = {
                enabled = true
            },
            snippets = {
                user_path = "~/.local/share/nvim/coq-snips/"
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
    netrw_browsex_viewer = "xdg-open",
    edge_style = "neon",
    floaterm_position = "topleft",
    floaterm_autoclose = 2,
    floaterm_opener = "vsplit"
}

for k, v in pairs(vimg) do
    vim.g[k] = v
end

--- }}}

-- Local and Global Lua Variables {{{
local capabilities = vim.lsp.protocol.make_client_capabilities()
--- }}}

-- Setup Functions {{{
-- Personal Configs {{{
require("plugins").setup()
require("keybindings").setup()
require("options").setup()
require("evil").setup()
require("commands").setup()
--- }}}
-- Other Configs {{{
require("nvim-lsp-installer").setup()
require("gitsigns").setup(
    {
        current_line_blame = true
    }
)
require("onedark").load()
require("onedark").setup(
    {
        style = "darker"
    }
)
require("nvim-autopairs").setup()
require("crates").setup(
    {
        src = {
            coq = {
                enabled = true,
                name = "crates.nvim"
            }
        }
    }
)

require("coq_3p")(
    {
        {src = "nvimlua"},
        {src = "bc", short_name = "MATH", precision = 6},
        {src = "figlet"}
    }
)
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
" colorscheme onedark
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
-- Auto-Compile COQsnips {{{
vim.api.nvim_create_autocmd(
    {
        "FileType coq-snip",
        "BufWrite"
    },
    {
        pattern = "*.snip",
        command = "COQsnips compile"
    }
)

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
