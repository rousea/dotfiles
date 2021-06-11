" Code
syntax enable
set number
"set showcmd

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

" Statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" this is required for some reason?
let branchname=StatuslineGit()

set statusline=
set statusline+=%{branchname}
set statusline+=%#LineNr# " change highlight group
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Coloring
set background=dark
"colorscheme solarized
colorscheme nord
set t_Co=256

let g:netrw_altv=1

call plug#begin('~/.vim/plugged')
Plug 'junegunn/limelight.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ }

nmap <F5> <Plug>(lcn-menu)
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)

let g:limelight_conceal_ctermfg = 'gray'
"autocmd VimEnter * Limelight

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

" replace all 2 spaces with tabs
nnoremap <F1> :set tabstop=2 expandtab! <bar> %retab! <CR>

" show spaces and tabs
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>

" remove trailing whitespace
:command Rtws %s/\s\+$//e

" don't remove indent on python comment
au! FileType python setl nosmartindent

" stops the focus gained/lost characters inserted?
set t_fd=
set t_fe=

let g:netrw_banner = 0 " No banner
let g:netrw_liststyle = 3 " Tree style
let g:netrw_browse_split = 4 " Open in previous window
let g:netrw_altv = 1 " Right splitting
let g:netrw_winsize = 15 " Window size
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore " Open netrw on start
"  autocmd VimEnter * :wincmd l " move to right window
"augroup END
