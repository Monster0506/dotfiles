#!                              
HOME = os.getenv("HOME")
local Plug = vim.fn['plug#']
vim.call('plug#begin')
        Plug 'preservim/nerdtree' 
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
        Plug 'SirVer/ultisnips'
        Plug 'Honza/vim-snippets'
        --Plug 'williamboman/nvim-lsp-installer'

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
vim.api.nvim_set_keymap(
        "n",
        "K",
        ":call ShowDocumentation()<CR>",
        { noremap = true, silent=true }
        )
vim.cmd([[
function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
        else
        call feedkeys('K', 'in')
        endif
        endfunction
        " bad 
        nnoremap <Space>cl <Plug>NERDCommenterToggle 
        nnoremap <C-_> <Plug>NERDCommenterToggle 
        inoremap <C-_> <Plug>NERDCommenterToggle 
        vnoremap <C-_> <Plug>NERDCommenterToggle 
        command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
        " autocmd CursorHold * silent call CocActionAsync('highlight')

]])
vim.api.nvim_set_keymap(
        "n",
        "<c-_>",
        "<plug>NERDCommenterToggle",
        { noremap = true }
)




vim.g.UltiSnipsEditSplit="vertical"
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.airline_right_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_left_alt_sep= ''
vim.g.airline_left_sep = ''



-- vim.NERDTreeWinPos="right"
--require("nvim-lsp-installer").setup {}
local lspconfig = require('lspconfig')

-- Automatically start coq
-- Keybindings I am too lazy to put in the proper format. {{{
vim.cmd([[

nnoremap <silent> <C-t> :NERDTreeToggle<CR>
" --nnoremap gd <Plug>(coc-definition)
" --nnoremap <F2> <Plug>(coc-rename)
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
        ]])
-- }}}
-- }}}
vim.g.UltiSnipsEditSplit="vertical"
vim.g['deoplete#enable_at_startup'] = 1
