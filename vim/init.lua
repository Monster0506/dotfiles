#!/usr/bin/env lua
HOME = os.getenv("HOME")
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
Plug "preservim/nerdtree"
Plug "mattn/webapi-vim"
Plug "morhetz/gruvbox"
Plug "easymotion/vim-easymotion"
Plug "sbdchd/neoformat"
Plug "ryanoasis/vim-devicons"
Plug "preservim/nerdcommenter"
Plug "tpope/vim-repeat"
Plug "tpope/vim-surround"
Plug "mg979/vim-visual-multi"
Plug "mattn/emmet-vim"
Plug "ap/vim-css-color"
Plug "vim-airline/vim-airline"
Plug "kien/ctrlp.vim"
Plug "sheerun/vim-polyglot"
Plug "vim-syntastic/syntastic"
Plug "hrsh7th/nvim-cmp"
Plug "neovim/nvim-lspconfig"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/nvim-cmp"
Plug "Honza/vim-snippets"
Plug "hrsh7th/cmp-nvim-lsp-signature-help"
-- For ultisnips users.
Plug "SirVer/ultisnips"
Plug "quangnguyen30192/cmp-nvim-ultisnips"

Plug "nvim-treesitter/nvim-treesitter"
Plug "rust-lang/rust.vim"
Plug "github/copilot.vim"

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
vim.colorsheme = "gruvbox"
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_keymap("n", "<C-t>", ":NERDTreeToggle<cr>", {noremap = true, silent = true})
vim.cmd([[


]])
vim.api.nvim_set_keymap("n", "<c-_>", "<plug>NERDCommenterToggle", {noremap = true})

vim.g.airline_right_alt_sep = ""
vim.g.airline_right_sep = ""
vim.g.airline_left_alt_sep = ""
vim.g.airline_left_sep = ""

--vim.NERDTreeWinPos="right"
--require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

-- Keybindings I am too lazy to put in the proper format. {{{
vim.cmd(
    [[

nnoremap <silent> <C-t> :NERDTreeToggle<CR>
let NERDTreeWinPos = "right"  
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
vnoremap <leader>y "+y
nnoremap + <C-a>
" Fix typos {{{
command! W :w
command! WQ :wq
command! Wq :wq
command! Q :q
command! Noh :noh
command! Nog :noh



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

        ]]
)
-- }}}
-- }}}
local cmp = require "cmp"

cmp.setup(
    {
        snippet = {
            -- REQUIRED - you must specify a snippet engine
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
                ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "ultisnips"},
                {name = "buffer"},
                {name = "nvim_lsp_signature_help"}
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
cmp.setup.cmdline(
    "/",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = {noremap = true, silent = true}
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
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
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, bufopts)
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
require("lspconfig")["tsserver"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require("lspconfig")["rust_analyzer"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            capabilities = capabilities
        }
    }
}

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
