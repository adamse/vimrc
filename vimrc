let g:fzf_command_prefix="Fzf"

execute pathogen#infect()

syntax on
filetype indent on
set background=light

set enc=utf-8

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

" but not for makefiles :)
autocmd FileType make set noexpandtab

" backspace over everything
set backspace=indent,eol,start

" tree style file listing
let g:netrw_liststyle = 3

" always show the status line
set laststatus=2

" statusline with git info
set statusline=%<%f\ %{FugitiveStatusline()}\ %{coc#status()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

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

" open files with folds open
set foldlevelstart=99

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

tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-h> <C-w>h
tnoremap <C-l> <C-w>l

" I often mistype these :)
cabbrev Grep grep
cabbrev E e
cabbrev W w
nmap K <Nop>

" kill eol whitespace
augroup EOL
  au!
  autocmd FileType haskell autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType c autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType vim autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType nix autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType markdown autocmd BufWritePre <buffer> %s/\s\+$//e
augroup end

command! Ws %s/\s\+$//e

" haskell
"augroup haskell
"  au!
"  autocmd FileType haskell setlocal tags=hstags
"augroup end

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

" grep for word under cursor
command! Gword grep "\b<cword>\b"

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" coc.vim
nmap <space>n <Plug>(coc-diagnostic-next)
nmap <space>p <Plug>(coc-diagnostic-prev)
nmap <space>a <Plug>(coc-codeaction-line)
nmap <space>d <Plug>(coc-definition)

" mapping for fzf
nnoremap <c-p> :FzfFiles<CR>

" nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
