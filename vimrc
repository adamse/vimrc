let g:fzf_command_prefix="Fzf"
let mapleader="<Space>"

" rust
let g:rustfmt_autosave = 1

execute pathogen#infect()

syntax on
filetype plugin indent on
set background=dark

set enc=utf-8

set autoindent
" disable autoindent
autocmd FileType yaml filetype indent off
autocmd FileType tex filetype indent off

" j: remove comment when joining lines, where it makes sense
" r: automatically insert current comment leader if Enter in Insert mode
" o: same as r but for o in normal mode
autocmd FileType asm set formatoptions+=jro comments=:;
autocmd FileType python set formatoptions+=jro

" html indent is janky
autocmd FileType html setlocal indentexpr=
autocmd FileType html setlocal smartindent

" cmake indent is janky
autocmd FileType cmake setlocal indentexpr=
autocmd FileType cmake setlocal smartindent

" put swapfiles elsewhere
set directory-=.

" sane tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" text wrapping in comments etc
set tw=120

" but not for makefiles :)
autocmd FileType make setlocal noexpandtab

" backspace over everything
set backspace=indent,eol,start

" tree style file listing
let g:netrw_liststyle = 3

" always show the status line
set laststatus=2

function! CocStatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" statusline with git info
" f: path to file
" n: buffer number
" h: help buffer flag
" m: modified
" r: readonly
set statusline=%<%f\ %n\ %{FugitiveStatusline()}\ %{CocStatusDiagnostic()}%h%m%r%=%-14.(%l,%c%V%)\ %P

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

nnoremap ; :
vnoremap ; :

" better window management
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if !has('nvim')
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-h> <C-w>h
  tnoremap <C-l> <C-w>l
  tnoremap <Esc>gt <C-w>gt
  tnoremap <Esc>gT <C-w>gT
else
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc>gt <C-\><C-N><C-w>gt
  tnoremap <Esc>gT <C-\><C-N><C-w>gT
end

tnoremap <Esc><Esc> <C-\><C-n>

augroup FzfNormalEscape
  au!
  au FileType fzf tnoremap <buffer> <Esc><Esc> <Esc><Esc>
augroup END

" open buffer in new tab
nnoremap <silent> <C-w>z :tab split<CR>
tnoremap <silent> <C-w>z <C-w>:tab split<CR>

" I often mistype these :)
cabbrev Grep grep
cabbrev E e
cabbrev W w
nmap K <Nop>

" kill eol whitespace
augroup EOL
  au!
  autocmd FileType haskell autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType c autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType vim autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType python autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType nix autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType markdown autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType bsc autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType rust autocmd BufWritePre <buffer> RemoveTrailingSpaces
  autocmd FileType asm autocmd BufWritePre <buffer> RemoveTrailingSpaces
augroup end

command! Ws %s/\s\+$//e

augroup Things
  au!
  " makes gq formatting of paragraphs work in haskell comments
  autocmd FileType haskell setlocal comments+=b:--
augroup end

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

map F :call ShowCishFuncName() <CR>

" grep for word under cursor
command! Gword grep "\b<cword>\b"

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" coc.vim
nmap <space>n <Plug>(coc-diagnostic-next)
nmap <space>p <Plug>(coc-diagnostic-prev)
nmap <space>a <Plug>(coc-codeaction-line)
vmap <space>a <Plug>(coc-codeaction-selected)
nmap <space>d <Plug>(coc-definition)

" default is 4s, creating a poor user experience (especially for coc.vim)
set updatetime=250

" mapping for fzf
nnoremap <c-p> :FzfFiles<CR>
nnoremap <c-b> :FzfBuffers<CR>

" nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" vim-autoformat
augroup autoformat
  au!
  " autocmd FileType rust autocmd BufWrite :Autoformat
augroup end

" https://github.com/tpope/vim-fugitive/issues/1350
command! NoBind set noscrollbind | set nocursorbind

" haskell
let hs_allow_hash_operator = 1

if !has('nvim')
  command! Ghci terminal ++close ghci
  command! -nargs=+ Man terminal ++close man <args>
endif

" go to previous tab, gr because it is close to gt which moves to the next tab
nnoremap <silent> gr :tabprevious<CR>

" easier V
nnoremap vv V

" run a command in the terminal, indirection so we can properly put the \<CR> in place
function! Run(termno, command)
    call term_sendkeys(a:termno, a:command . "\<CR>")
endfunction

" install <space>r mapping to run a command in a terminal buffer
function! InstallRun(termno, command)
    execute "nnoremap <silent> <space>r :call Run(" . a:termno . ", \"" . a:command . "\")<CR>"
endfunction!

nnoremap <space>r :call InstallRun(termno, command

execute "nnoremap , :Rg -w <cword> "

" make a small terminal window
command! Sm new | set wfh | resize 10 | terminal ++curwin

" BUCK files are starlark/bzl
autocmd BufReadPre,FileReadPre BUCK set filetype=bzl

" jsonc
autocmd BufRead,BufNewFile coc-settings.json set filetype=jsonc

" siable
let g:Illuminate_ftblacklist = ['forth']

command! Gadd Git add %
command! Gstatus Git

autocmd FileType rust set matchpairs+=<:>
autocmd FileType cpp set matchpairs+=<:>
