"if &compatible
"  set nocompatible
"endif

call plug#begin(fnamemodify(expand('<sfile>'), ':h').'/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mhinz/vim-startify'
"Plug 'mhinz/vim-janah'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround' " ds<delimiter> etc.
Plug 'machakann/vim-highlightedyank'
Plug 'terryma/vim-multiple-cursors' " normal mode, <c-n> to select, <c-c> to stop selection
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common settings
set encoding=utf-8
set number
set undolevels=1000
" tab and shift width
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" increase and highlight search
set incsearch
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common mappings
let mapleader=','
nnoremap wi <c-w>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <Tab> :bnext!<cr>
nnoremap <S-Tab> :bprev!<cr><paste>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" janah colorscheme
"try
  "colorscheme janah
  "autocmd ColorScheme janah highlight Normal ctermbg=235
  "colorscheme mayormaynotexist
"catch /^Vim\%((\a\+)\)\=:E185/
  "colorscheme default
"endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf-vim
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
nnoremap <c-p> :Files<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi-vim
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
autocmd FileType python setlocal completeopt-=preview
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd FileType python nnoremap <buffer> <F5> :exec 'terminal python3' shellescape(@%, 1)<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-highlightedyank
hi HighlightedyankRegion cterm=reverse gui=reverse

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <F4> :NERDTreeToggle<cr>
inoremap <F4> <c-o>:NERDTreeToggle<cr>
nnoremap <F2> :Startify<cr>
inoremap <F2> <c-o>:Startify<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
let g:airline#extensions#tabline#enabled=1
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" build mappings
nnoremap <F7> :make<cr>
inoremap <F7> <c-o>:make<cr>
autocmd FileType c,cpp setlocal makeprg=make\ \-C\ cmake-build-Release
