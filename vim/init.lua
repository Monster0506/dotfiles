#!/usr/bin/env lua
HOME = os.getenv("HOME")
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Completion
Plug "onsails/lspkind.nvim"
Plug "hrsh7th/nvim-cmp"
Plug "hrsh7th/cmp-emoji"
Plug "nvim-lua/plenary.nvim"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "Saecki/crates.nvim"
Plug "hrsh7th/cmp-calc"
Plug "stevearc/dressing.nvim"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/nvim-cmp"
Plug "thaerkh/vim-indentguides"
Plug "hrsh7th/cmp-nvim-lsp-document-symbol"
Plug "hrsh7th/cmp-nvim-lsp-signature-help"
-- For ultisnips.
Plug "Honza/vim-snippets"
Plug "SirVer/ultisnips"
Plug "quangnguyen30192/cmp-nvim-ultisnips"

-- language plugins
Plug "neovim/nvim-lsp"
Plug "sheerun/vim-polyglot"
Plug "simrat39/rust-tools.nvim"
Plug "rust-lang/rust.vim"

Plug "vim-syntastic/syntastic"
Plug "neovim/nvim-lspconfig"
Plug "sbdchd/neoformat"
Plug "mattn/emmet-vim"
Plug "nvim-treesitter/nvim-treesitter"
Plug "ap/vim-css-color"
Plug "preservim/nerdcommenter"

-- Utility plugins
Plug "jiangmiao/auto-pairs"
Plug "romainl/vim-cool"
Plug "kyazdani42/nvim-web-devicons"
Plug "matze/vim-move"
Plug "ellisonleao/glow.nvim"
Plug "folke/trouble.nvim"
Plug "nvim-telescope/telescope.nvim"
Plug "preservim/nerdtree"
Plug "sudormrfbin/cheatsheet.nvim"
Plug "mattn/webapi-vim"
Plug "easymotion/vim-easymotion"
Plug "tpope/vim-repeat"
Plug "ryanoasis/vim-devicons"
Plug "tpope/vim-surround"
Plug "mg979/vim-visual-multi"
Plug "axieax/urlview.nvim"
Plug "sjl/badwolf"
Plug "morhetz/gruvbox"
Plug "vim-airline/vim-airline"
Plug "kien/ctrlp.vim"

vim.call("plug#end")
--print(HOME)
vim.opt.background = "dark"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.undodir = "~/.vim/undodir"
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.ignorecase = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.wildignore = "*.docx,*.pdf,*.exe,*.mcmeta,*.xlsx"
vim.opt.colorcolumn = "80"
vim.opt.foldmethod = "marker"

vim.cmd([[colorscheme badwolf]])
vim.api.nvim_set_keymap("n", "<c-_>", "<plug>NERDCommenterToggle", {noremap = true})

vim.g.airline_right_alt_sep = ""
vim.g.airline_right_sep = ""
vim.g.airline_left_alt_sep = ""
vim.g.airline_left_sep = ""

--require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

-- Keybindings I am too lazy to put in the proper format.
vim.cmd(
    [[

augroup fmt
  autocmd!
  autocmd BufWritePre * silent Neoformat
augroup END


noremap (<CR> (<CR>)<Esc>O
inoremap (;    (<CR>);<Esc>O 
inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [;    [<CR>];<Esc>O
inoremap [,    [<CR>],<Esc>O
inoremap :check: ✓
map <leader>ss :setlocal spell!<CR>
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>%       :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap p pzz
nnoremap P Pzz
nnoremap <C-a> ggVG
vnoremap <C-a> ggVG
nnoremap <CR> <CR>zz
nnoremap j gjzz
nnoremap k gkzz
nnoremap Y y$
nnoremap G Gzz
nnoremap gg ggzz
nnoremap H Hzz
nnoremap M Mzz
nnoremap L Lzz
nnoremap N Nzz
nnoremap n nzz
vnoremap <leader>y "+y
nnoremap + <C-a>
command! W :w
command! WQ :wq
command! Wq :wq
command! Q :q
command! Noh :noh
command! Nog :noh
nnoremap <silent><C-t> :NERDTreeToggle<CR>
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd VimEnter * NERDTree | wincmd p
let NERDTreeWinPos="right"


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

        ]]
)
-- }}}
-- nvim-completions
local cmp = require "cmp"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true})
            }
        ),
        view = {
            entries = {name = "custom", selection_order = "near_cursor"}
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "calc"},
                {name = "ultisnips"},
                {name = "buffer"},
                {name = "crates"},
                {name = "nvim_lsp_signature_help"},
                {name = "emoji"}
            }
        )
    }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
    "gitcommit",
    {
        sources = cmp.config.sources(
            {
                {name = "cmp_git"} -- You can specify the `cmp_git` source if you were installed it.
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
require "cmp".setup.cmdline(
    "/",
    {
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp_document_symbol"}
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"},
                {name = "calc"},
                {name = "cmdline"}
            }
        )
    }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = {noremap = true, silent = true}
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.hover, bufopts)
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
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 50
}
require("lspconfig")["pyright"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require("lspconfig")["tsserver"].setup {}
require("lspconfig").bashls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require("lspconfig").ccls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require("lspconfig")["rust_analyzer"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {}
    }
}
require("crates").setup()
vim.api.nvim_set_keymap("n", "K", ":lua show_documentation()<CR>", {noremap = true, silent = true})
function show_documentation()
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

require("cmp").setup(
    {
        view = {
            entries = {name = "custom", selection_order = "near_cursor"}
        },
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0
            }
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                local kind = require("lspkind").cmp_format({mode = "symbol_text", maxwidth = 50})(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", {trimempty = true})
                kind.kind = " " .. strings[1] .. " "
                kind.menu = "    (" .. strings[2] .. ")"

                return kind
            end
        }
    }
)

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {["<leader><c-t>"] = trouble.open_with_trouble},
            n = {["<leader><c-t>"] = trouble.open_with_trouble}
        }
    }
}

require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "rust",
        "lua",
        "cpp",
        "bash",
        "javascript",
        "tsx",
        "toml",
        "css",
        "json"
    },
    highlight = {
        enable = true
    }
}
