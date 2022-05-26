" COC {{{

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


inoremap <silent><expr> <TAB>
\ pumvisible() ? coc#_select_confirm() :
\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}

" Plugins {{{
call plug#begin() 

        Plug 'preservim/nerdtree' 
        " Plug 'SirVer/ultisnips'
        Plug 'morhetz/gruvbox'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
        "Plug 'honza/vim-snippets'
        Plug 'sheerun/vim-polyglot'
        Plug 'vim-syntastic/syntastic'

call plug#end()

" }}}

" NERDTree {{{

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnfugitive'fugitive'r() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * NERDTree | wincmd p
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
let NERDTreeWinPos="right"

" }}}

" AIRLINE {{{
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

" }}}

" NERD COMMENTER {{{
" Highlight currently open buffer in NERDTree
" a bad habit from spacevim
nnoremap <Space>cl <Plug>NERDCommenterToggle 
nnoremap <C-_> <Plug>NERDCommenterToggle 
inoremap <C-_> <Plug>NERDCommenterToggle 
vnoremap <C-_> <Plug>NERDCommenterToggle 
" }}}
" SOME USEFUL PYTHON STUFF {{{

syn keyword pythonDecorator True None False self
augroup testGroup
        autocmd!
        autocmd filetype python inoremap $i import  
        autocmd filetype python inoremap $r return
        autocmd filetype python inoremap $p print
        au filetype python inoremap $f # --- <esc>a
        au BufWrite *.py silent! Neoformat black
        au filetype python inoremap this self
        au filetype python nnoremap <leader>d /def
        au filetype python noremap <leader>c /class
        au filetype python inoremap this self
        au filetype python inoremap null None
        au filetype python syn keyword pythonDecorator True None False self
        au filetype python set foldmethod=indent
augroup END


" }}}

" BASIC VIM CONFIG {{{
au BufWinEnter * highlight ColorColumn ctermbg=green
au BufWinEnter * SyntasticCheck
set colorcolumn=80

set foldmethod=marker                           
syntax case ignore

set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.mcmeta
set nocompatible
filetype on
filetype plugin on
set nobackup
set noswapfile
set ignorecase
set backspace=indent,eol,start
set expandtab
set undodir=~/.vim/undodir/
set path+=**
set smartcase
set mouse=a
set number
set relativenumber

" BASIC MAPPINGS {{{
nnoremap <silent> <C-t> :NERDTreeToggle<CR>
nnoremap gd <Plug>(coc-definition)
nnoremap <F2> <Plug>(coc-rename)
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
vnoremap <leader>y "+y
nnoremap + <C-a>
" Fix typos {{{
command! W :w
command! WQ :wq
command! Wq :wq
command! Q :q
" }}}

" NEXT OBJECT MAPPING {{{
" https://gist.github.com/AndrewRadev/1171559
onoremap an :<c-u>call <SID>NextTextObject('a')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i')<cr>

function! s:NextTextObject(motion)
  echo
  let c = nr2char(getchar())
  exe "normal! f".c."v".a:motion.c
endfunction
" }}}
set background=dark
color gruvbox

" }}}

" TODO
hi Todo ctermbg=red
" }}}
