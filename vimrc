execute pathogen#infect()

syntax on
filetype indent on
set background=light

set autoindent
" disable autoindent
autocmd FileType yaml filetype indent off
autocmd FileType tex filetype indent off

" put swapfiles elsewhere
set directory-=.

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
set fillchars+=vert:\  " a space char
hi VertSplit guibg=bg guifg=fg
" hi VertSplit cterm=bg ctermbg=fg

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
augroup EOL
  au!
  autocmd FileType haskell autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType c autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType vim autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
augroup end

" set cursor to bar in insert mode
let &t_ti.="\e[1 q"
let &t_te.="\e[0 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

" find C function name
fun! ShowCishFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun

augroup CishFunctionName
  au!
  autocmd FileType c map F :call ShowCishFuncName() <CR>
  autocmd FileType cpp map F :call ShowCishFuncName() <CR>
augroup end

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
