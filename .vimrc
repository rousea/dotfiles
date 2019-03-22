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
colorscheme monokai
set t_Co=256

let g:netrw_altv=1

"call plug#begin('~/.vim/plugged')
"Plug 'artur-shaik/vim-javacomplete2'
"call plug#end()

"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"
noremap <silent> j gj
noremap <silent> k gk

" remap (; to open and skip a line
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
"inoremap ({ () {}<left><left><left><left>
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" insert no recurse map
"inoremap ( ()<left>
"inoremap [ []<left>

" TODO vim doesn't get this key combo, someone intercepts before-hand
inoremap <C-q> <esc>:q<cr>
nnoremap <C-q> :q<cr>

vnoremap // y/<C-R>"<CR>

" H in normal mode scrolls to n lines from the top of the window
noremap <Leader>e :Explore<CR>
noremap <Leader>he :Hexplore<CR>
" ! appended to the explore(s) switches the split side
noremap <Leader>ve :Vexplore!<CR>
