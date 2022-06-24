#!/usr/bin/env lua
HOME = os.getenv("HOME")
--print(HOME)

-- Plugins {{{
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Completions
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
Plug "hrsh7th/cmp-nvim-lsp-signature-help"
Plug "jose-elias-alvarez/null-ls.nvim"
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
Plug "RRethy/nvim-treesitter-textsubjects"
Plug "ap/vim-css-color"
Plug "preservim/nerdcommenter"

--!  Utility plugins
Plug "lewis6991/gitsigns.nvim"
-- No longer using vim-gitgutter
-- Plug "airblade/vim-gitgutter"
Plug "jiangmiao/auto-pairs"
Plug("wfxr/minimap.vim", {["do"] = ":!cargo install --locked code-minimap"})
Plug "romainl/vim-cool"
Plug "kyazdani42/nvim-web-devicons"
Plug "romgrk/barbar.nvim"
Plug "matze/vim-move"
Plug "ellisonleao/glow.nvim"
Plug "folke/trouble.nvim"
Plug "preservim/nerdtree"
Plug "sudormrfbin/cheatsheet.nvim"
Plug "mattn/webapi-vim"
Plug "easymotion/vim-easymotion"
Plug "tpope/vim-repeat"
Plug "ryanoasis/vim-devicons"
Plug "tpope/vim-surround"
Plug "axieax/urlview.nvim"
Plug "sjl/badwolf"
Plug "morhetz/gruvbox"
Plug "vim-airline/vim-airline"
Plug "ctrlpvim/ctrlp.vim"
-- Telescope Plugins
Plug "nvim-telescope/telescope.nvim"
Plug "fhill2/telescope-ultisnips.nvim"

vim.call("plug#end")
-- }}}

--- local variables {{{
actions = require("telescope.actions")
trouble = require("trouble.providers.telescope")
telescope = require("telescope")
lspconfig = require("lspconfig")
cmp = require "cmp"
tsconfig = require("nvim-treesitter.configs")
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
opts = {noremap = true, silent = true}
crates = require("crates")
keymap = vim.api.nvim_set_keymap
--- }}}

-- vim.opts {{{
local vimopts = {
    background = "dark",
    relativenumber = true,
    number = true,
    smartcase = true,
    mouse = "a",
    ignorecase = true,
    undodir = "~/.vim/undodir",
    expandtab = true,
    backup = false,
    swapfile = false,
    wildignore = "*.docx,*.pdf,*.exe,*.mcmeta,*.xlsx",
    colorcolumn = "80",
    foldmethod = "marker"
}
-- set vim options
for k, v in pairs(vimopts) do
    vim.opt[k] = v
end

-- }}}

-- vim.gs (global variables) {{{
local vimg = {
    airline_right_alt_sep = "",
    NERDSpaceDelims = 1,
    airline_left_sep = "",
    airline_left_alt_sep = "",
    airline_right_sep = ""
}

for k, v in pairs(vimg) do
    vim.g[k] = v
    -- print(k, v)
end

-- }}}

-- vim settings and keybindings {{{
vim.cmd(
    [[
colorscheme badwolf
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
vnoremap p pzz
vnoremap P Pzz
vnoremap <C-a> ggVG
vnoremap <CR> <CR>zz
vnoremap j gjzz
vnoremap k gkzz
vnoremap Y y$
vnoremap G Gzz
vnoremap gg ggzz
vnoremap H Hzz
vnoremap M Mzz
vnoremap L Lzz
vnoremap N Nzz
vnoremap n nzz
vnoremap <C-a> ggVG
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
" MKDIR: https://stackoverflow.com/a/4294176
function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


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
-- }}}

-- keybindings {{{

-- window resizing {{{
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- }}}

--- }}}

-- nvim-completion settings {{{

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
cmp.setup.cmdline(
    "/",
    {
        sources = cmp.config.sources(
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
cmp.setup(
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
-- }}}

-- Language server settings {{{
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
lspconfig["pyright"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
lspconfig["tsserver"].setup {}
lspconfig.bashls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

lspconfig.ccls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

lspconfig["rust_analyzer"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {}
    }
}
crates.setup()
keymap("n", "K", ":lua show_documentation()<CR>", opts)
function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({"vim", "help"}, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({"man"}, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif vim.fn.expand("%:t") == "Cargo.toml" then
        crates.show_popup()
    else
        vim.lsp.buf.hover()
    end
end

-- }}}

-- Telescope settings {{{
telescope.load_extension("ultisnips")

telescope.setup {
    defaults = {
        mappings = {
            i = {["<leader><c-t>"] = trouble.open_with_trouble},
            n = {["<leader><c-t>"] = trouble.open_with_trouble}
        }
    }
}

tsconfig.setup {
    ensure_installed = {
        "rust",
        "lua",
        "cpp",
        "bash",
        "javascript",
        "typescript",
        "tsx",
        "toml",
        "python",
        "css",
        "json"
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true
    }
}
tsconfig.setup {
    textsubjects = {
        enable = true,
        prev_selection = ",", -- (Optional) keymap to select the previous selection
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner"
        }
    }
}
-- }}}

-- Misc {{{
require("null-ls").setup(
    {
        debug = true
    }
)

require("gitsigns").setup()
-- }}}
