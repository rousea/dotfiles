" Code
syntax enable
set number
set showcmd

" Spacing / Tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set si

set title

set cursorline
set cursorcolumn

set colorcolumn=80

set hlsearch

set lazyredraw
set laststatus=2

" Coloring
set background=dark
colorscheme seoul256
set t_Co=256

call plug#begin('~/.vim/plugged')
"Plug 'artur-shaik/vim-javacomplete2'
call plug#end()

"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"
noremap <silent> j gj
noremap <silent> k gk

" remap (; to open and skip a line
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O
