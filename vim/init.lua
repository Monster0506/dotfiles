#!/usr/bin/env lua

HOME = os.getenv("HOME")
local Plug = vim.fn['plug#']
vim.call('plug#begin')
        Plug 'preservim/nerdtree' 
        Plug 'mattn/webapi-vim'
        Plug 'morhetz/gruvbox'
        Plug 'easymotion/vim-easymotion' 
        Plug 'sbdchd/neoformat' 
        Plug 'ryanoasis/vim-devicons'
        Plug 'preservim/nerdcommenter'
        Plug 'tpope/vim-repeat'
        Plug 'tpope/vim-surround'
        Plug 'mg979/vim-visual-multi'
        Plug 'mattn/emmet-vim'
        Plug 'ap/vim-css-color'
        Plug 'vim-airline/vim-airline'
        Plug 'kien/ctrlp.vim'
        Plug 'sheerun/vim-polyglot'
        Plug 'vim-syntastic/syntastic'
        Plug 'neovim/nvim-lspconfig'
        Plug 'Honza/vim-snippets'
        Plug 'rust-lang/rust.vim'
        Plug 'github/copilot.vim'
        Plug ('neoclide/coc.nvim', {branch='release'})

vim.call('plug#end')
--print(HOME)
vim.opt.background = "dark"
vim.opt.relativenumber=true
vim.opt.number=true
vim.opt.mouse="a"
vim.opt.smartcase=true
vim.opt.undodir="~/.vim/undodir"
vim.opt.expandtab=true
vim.opt.backspace="indent,eol,start"
vim.opt.ignorecase=true

vim.opt.backup=false
vim.opt.swapfile=false
vim.opt.ignorecase=true
vim.opt.wildignore="*.docx,*.pdf,*.exe,*.mcmeta,*.xlsx"
vim.opt.colorcolumn="80"
vim.opt.foldmethod="marker"
vim.colorsheme="gruvbox"
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_keymap(
        "n",
        "<C-t>",
        ":NERDTreeToggle<cr>",
        { noremap = true, silent=true }
)
vim.cmd([[


]])
vim.api.nvim_set_keymap(
        "n",
        "<c-_>",
        "<plug>NERDCommenterToggle",
        { noremap = true }
)

vim.api.nvim_set_keymap(
        "n",
        "<C-LeftMouse>",
        "<LeftMouse>:call Show_documentation()<CR>",
        { noremap = true, silent = true }
	)

vim.g.airline_right_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_left_alt_sep= ''
vim.g.airline_left_sep = ''



 --vim.NERDTreeWinPos="right"
--require("nvim-lsp-installer").setup {}
local lspconfig = require('lspconfig')

-- Keybindings I am too lazy to put in the proper format. {{{
vim.cmd([[

nnoremap <silent> <C-t> :NERDTreeToggle<CR>
let NERDTreeWinPos = "right"  
augroup fmt
  autocmd!
  autocmd BufWritePre * silent Neoformat
augroup END
nnoremap gd <Plug>(coc-definition)
nnoremap <F2> <Plug>(coc-rename)
nnoremap <silent> K :call Show_documentation()<CR>

inoremap <silent><expr> <TAB>pumvisible() ? "\<C-n>" :Check_back_space() ? "\<TAB>" :coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! Show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <P
autocmd CursorHold * silent call CocActionAsync('highlight')
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
  if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
        ]])
-- }}}
-- }}}
vim.g.UltiSnipsEditSplit="vertical"
