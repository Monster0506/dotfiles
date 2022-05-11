function! Myspacevim#before() abort
  autocmd BufWritePost * silent Neoformat
  call Mappings()
  set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.mcmeta
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
endfunc

function! PythonStuff() abort
  inoremap $r return
  inoremap $i import
  inoremap $p print
  inoremap $f # --- <esc>a
  nnoremap <leader>d /def
  noremap <leader>c /class
  au FileType python syn keyword pythonDecorator True None False self
  set foldmethod=indent<cr>
endfunc


function! Mappings() abort

  au FileType python :call PythonStuff()
  noremap (<CR> (<CR>)<Esc>O
  inoremap (;    (<CR>);<Esc>O
  inoremap (,    (<CR>),<Esc>O
  inoremap {<CR> {<CR>}<Esc>O
  inoremap {;    {<CR>};<Esc>O
  inoremap {,    {<CR>},<Esc>O
  inoremap [<CR> [<CR>]<Esc>O
  inoremap [;    [<CR>];<Esc>O
  inoremap [,    [<CR>],<Esc>O
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
endfunc

