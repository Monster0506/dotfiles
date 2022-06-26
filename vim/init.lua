#!/usr/bin/env lua
HOME = os.getenv("HOME")

-- vim.gs (global variables) {{{
local vimg = {
    airline_right_alt_sep = "",
    NERDSpaceDelims = 1,
    airline_left_sep = "",
    airline_left_alt_sep = "",
    airline_right_sep = "",
    rainbow_active = 1,
    ale_disable_lsp = 1,
    ale_sign_warning = "",
    edge_style = "neon",
    NERDTreeDirArrowExpandable = " ",
    NERDTreeDirArrowCollapsible = " "
}

for k, v in pairs(vimg) do
    vim.g[k] = v
    -- print(k, v)
end

-- }}}

-- Plugins {{{
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
-- Telescope Plugins {{{
Plug "fannheyward/telescope-coc.nvim"
Plug "nvim-telescope/telescope-symbols.nvim"
Plug "BurntSushi/ripgrep"
Plug "sudormrfbin/cheatsheet.nvim"
Plug "nvim-telescope/telescope.nvim"
-- }}}
-- Completion Plugins {{{
Plug("neoclide/coc.nvim", {["branch"] = "release"})
-- }}}
-- Language Server Plugins {{{
Plug "dense-analysis/ale"
-- }}}
-- Snippet Plugins {{{
Plug "honza/vim-snippets"
Plug "sirVer/Ultisnips"
-- }}}
-- General Language Plugins {{{
-- Treesitter Plugins {{{
Plug "nvim-treesitter/nvim-treesitter"
Plug "RRethy/nvim-treesitter-textsubjects"
-- }}}
Plug "sheerun/vim-polyglot"
Plug "vim-syntastic/syntastic"
Plug "sbdchd/neoformat"
Plug "preservim/nerdcommenter"
Plug "luochen1990/rainbow"
-- }}}
-- Colorschemes and Appearance Plugins {{{
-- NerdTree Plugins {{{
Plug "preservim/nerdtree"
Plug "tiagofumo/vim-nerdtree-syntax-highlight"
-- }}}
-- Devicon Plugins {{{
Plug "kyazdani42/nvim-web-devicons"
Plug "ryanoasis/vim-devicons"
-- }}}
-- Colorschemes {{{
Plug "sjl/badwolf"
Plug "morhetz/gruvbox"
Plug "sainnhe/edge"
-- }}}
-- Statusline/bar {{{
Plug "vim-airline/vim-airline"
Plug "romgrk/barbar.nvim"
-- }}}
Plug "lewis6991/gitsigns.nvim"
Plug "thaerkh/vim-indentguides"
Plug "stevearc/dressing.nvim"
-- }}}
-- Specific Language Plugins {{{
-- HTML/CSS {{{
Plug "mattn/emmet-vim"
Plug "ap/vim-css-color"
-- }}}
-- Rust {{{
Plug "rust-lang/rust.vim"
Plug "Saecki/crates.nvim"
-- }}}
-- Markdown {{{
Plug "axieax/urlview.nvim"
-- }}}
-- }}}
-- Other Dependencies Plugins {{{
Plug "mattn/webapi-vim"
Plug "nvim-lua/plenary.nvim"
-- }}}
-- Movement Plugins {{{
Plug "easymotion/vim-easymotion"
Plug "matze/vim-move"
-- }}}
-- FZF Plugins {{{
Plug "ctrlpvim/ctrlp.vim"
-- }}}
-- Other Utility Plugins {{{
Plug "jiangmiao/auto-pairs"
Plug "tpope/vim-repeat"
Plug "tpope/vim-surround"
Plug "romainl/vim-cool"
-- }}}

vim.call("plug#end")
-- }}}

-- Local variables {{{
local tsconfig = require("nvim-treesitter.configs")
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
-- }}}

-- Setup Functions {{{
require("crates").setup {}
require("gitsigns").setup()
--- }}}

-- vim.opts {{{
vim.cmd([[set termguicolors]])
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

-- vim settings and keybindings {{{
vim.cmd(
    [[
colorscheme edge
augroup fmt
  autocmd!
  autocmd BufWritePre * silent Neoformat
augroup END

augroup CURSORLINE | autocmd!
    autocmd!
    autocmd VimEnter * set cursorline | autocmd VimLeave * set nocursorline
    autocmd WinEnter * set cursorline | autocmd WinLeave * set nocursorline
    autocmd InsertEnter * set nocursorline | autocmd InsertLeave * set cursorline
augroup end

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
keymap("n", "<M-Right>", "<cmd>tabnext<CR>", opts)
keymap("n", "<M-Left>", "<cmd>tabprevious<CR>", opts)

-- }}}

--- }}}

-- nvim-completion settings {{{

-- Setup lspconfig.

-- }}}

-- Language server settings {{{
-- }}}

-- Coc Settings {{{
vim.cmd(
    [[
" Basic settings {{{
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" }}}
" Completion triggers {{{
" Use tab for trigger completion with characters ahead and navigate. {{{
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" }}}
" CheckBackspace Function {{{
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}

" Use <c-space> to trigger completion. {{{
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" }}}

" Make <CR> auto-select the first completion item and notify coc.nvim to {{{
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}
" }}}
" Key bindings {{{
" Use `[g` and `]g` to navigate diagnostics {{{
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" }}}
" Use K to show documentation in preview window. {{{
nnoremap <silent> K :call ShowDocumentation()<CR>
" }}}
" GoTo code navigation. {{{
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" }}}
" Applying codeAction to the selected region. {{{
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" }}}
" Remap keys for applying codeAction to the current buffer. {{{
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" }}}
" Run the Code Lens action on the current line. {{{
nmap <leader>cl  <Plug>(coc-codelens-action)
" }}}
" Map function and class text objects {{{
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" }}}
" Remap <C-f> and <C-b> for scroll float windows/popups. {{{
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" }}}
" Use CTRL-S for selections ranges. {{{
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" }}}
" Formatting selected code. {{{
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" }}}
" Mappings for CoCList {{{
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Open yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" }}}
" Show Documentation Function {{{
function! ShowDocumentation()
if CocAction('hasProvider', 'hover')
call CocActionAsync('doHover')
else
if (index(['vim', 'help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
elseif (index(['man'], &filetype) >= 0)
execute 'Man '.expand('<cword>')
elseif (expand('%:t') == 'Cargo.toml')
lua require('crates').show_popup()
endif
endif
endfunction
" }}}

" }}}

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  ]]
)

--- }}}

-- Telescope settings {{{
require("telescope").load_extension("coc")
-- }}}
