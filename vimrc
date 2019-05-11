syntax on
filetype indent on
set background=light

set autoindent
" disable autoindent
autocmd FileType yaml let b:did_indent = 1
autocmd FileType yaml setlocal indentexpr=

" sane tabs
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" backspace over everything
set backspace=indent,eol,start

" tree style file listing
let g:netrw_liststyle = 3

" always show the status line
set laststatus=2

" statusline with git info
set statusline=%<%f\ %{FugitiveStatusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" vertical splitter style
" set fillchars+=vert:| " seems to be the default
hi VertSplit guibg=bg guifg=fg
hi VertSplit cterm=NONE ctermbg=NONE

" use rg for grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" open quickfix after grep
autocmd QuickfixCmdPost *grep* cwindow

" ignore case for filenames etc.
set wildignorecase

" ignore case in searchpatterns
set ignorecase

" incremental search
set incsearch

" format comments with gq
set formatoptions+=q

" expand %% to dir of open file
cabbr <expr> %% expand('%:p:h')

" active window after split
set splitright
set splitbelow

" better window management
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" I often mistype these :)
cabbrev Grep grep
cabbrev E e
cabbrev W w

" kill eol whitespace
autocmd FileType haskell autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType vim autocmd BufWritePre <buffer> %s/\s\+$//e

" set cursor to bar in insert mode
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" package management
set packpath+=~/.vim/pack/
