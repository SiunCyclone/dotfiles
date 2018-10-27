let s:is_darwin = system('uname') == "Darwin\n"
let s:is_linux = system('uname') == "Linux\n"
let s:is_msys = !s:is_darwin && !s:is_linux

" Excute at startup
if has('vim_starting')
  " Cut compatibility with vi
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Color Scheme
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jacoborus/tender.vim'

" QuickRun
NeoBundle 'thinca/vim-quickrun'
" Utility
" NeoBundle 'Shougo/unite.vim'
" SyntaxHighlight + Auto compile
NeoBundle 'kchmck/vim-coffee-script'
" Display under status bar
NeoBundle 'Lokaltog/vim-powerline'
" Buffer management like tab editor
NeoBundle 'fholgado/minibufexpl.vim'
" Copy and pasete between other vim
NeoBundle 'yanktmp.vim'
" Typescript Syntax Highlight
NeoBundle 'leafgarland/typescript-vim'
" Text Align
NeoBundle 'Align'
" File Tree Viewer
NeoBundle 'scrooloose/nerdtree'

" msys's vim is not included lua
if !s:is_msys
  " Complement
  NeoBundle 'Shougo/neocomplete'
  " Snippet
  NeoBundle 'Shougo/neosnippet'
  " Snippet Collections
  NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()
NeoBundleCheck

" Color of normal backgrounnd
autocmd ColorScheme,BufEnter * hi Normal ctermfg=252 ctermbg=233
" Color of line number
autocmd ColorScheme,BufEnter * hi LineNr ctermfg=74 ctermbg=236
" Color of current line
autocmd ColorScheme,BufEnter * hi CursorLineNr ctermfg=208
" Color of comment
autocmd ColorScheme,BufEnter * hi Comment ctermfg=247
" Color of tab
autocmd ColorScheme,BufEnter * hi SpecialKey ctermfg=74

colorscheme molokai
autocmd FileType typescript colorscheme tender

" yanktmp.vim control
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" NeoComplete settings
if !s:is_msys
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()
  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

syntax enable
" Enable adequate indent to filetype
filetype plugin indent on

" Delete start-up-message
set shortmess+=I
" Display the line number
set number
" Secure up-down-cursor-space
set scrolloff=8
" Always display statusline
set laststatus=2
" Enable mouse in all mode
set mouse=a
" Set the width of command line
set cmdheight=1
" Real-time search
set incsearch
" Doesn't make back up file
set nobackup
" Doesn't make swap file
set noswapfile
" Doesn't distinguish upper/lower case when searching
set ignorecase
" Distinguish only including upper case when searching
set smartcase
" Emphasize the search term
set hlsearch
" Display invisible character
set list
" Display tab
set listchars=tab:^-
" Replace Tab as Space
set expandtab
" Width of indent
set shiftwidth=2
" Width of tab
set tabstop=2
" Set F11 as paste mode
set pastetoggle=<F11>
" Complete command line
set wildmenu
" Set Zenkaku character as double Hankaku
set ambiwidth=double
" Setting of folding
set foldmethod=indent
" Level of folding
set foldlevel=100
" Enable backspace
set backspace=indent,eol,start
" Highlight cursor line
" set cursorline

set encoding=utf-8
" Auto detection
set fileencodings=utf-8,euc-jp,sjis
set fileformats=unix,dos,mac

" Open the file with specific encoding
command Es :e ++enc=shift_jis
command Ee :e ++enc=euc-jp
command Eu :e ++enc=utf-8

" Open the file with specific format
command Fd :e ++ff=dos
command Fm :e ++ff=mac
command Fu :e ++ff=unix

function! ToUni()
  set ff=unix
  set fenc=utf8
  w
endfunction
command W :call ToUni()

map <C-j> 10j
map <C-k> 10k
map <C-h> ^
map <C-l> $
imap <C-j> <Esc><C-j>i
imap <C-k> <Esc><C-k>i
imap <C-h> <Esc>^i
imap <C-l> <Esc>$a
nmap de dei
nnoremap :e :args<Space>
" Window control
nnoremap :ss :split
nnoremap :sv :vsplit
" Buffer control
nnoremap <silent>H :bp<CR>
nnoremap <silent>L :bn<CR>
nnoremap <silent><Space>d :bw<CR>
" Switching display tab or not
map tab :set noexpandtab<CR>
map ntab :set expandtab<CR>
" ColorScheme shortcut
map :cs :colorscheme
" Switching text-binary form
nnoremap <silent><Space>b :%!xxd -g 1<CR>
nnoremap <silent><Space>B :%!xxd -r<CR>
" Cancel the emphasis of searched term
nnoremap <silent><Esc><Esc> :nohl<CR>
" Open Nerd Tree
map :tr :NERDTree<CR>
" Ignore meta files(Nerd Tree)
let NERDTreeIgnore = ['\.meta$']

" Delete the-end-of-line-space when saving file
autocmd BufWritePre * :%s/\s\+$//ge
" Set .ts file to typescript
autocmd BufRead, BufNewFile *.ts set filetype=typescript

" Copy to clipboard
if s:is_linux
  vmap <C-c> :w !xsel -ib<CR><CR>
elseif s:is_darwin
  vmap <C-c> !pbcopy;pbpasete<CR>
endif
set clipboard=unnamed

" Highlight
augroup HilightsForce
    autocmd!
    autocmd WinEnter,BufRead,BufNew,Syntax * :silent! call matchadd('Todo', '\(TODO\|NOTE\|INFO\|XXX\|HACK\|THINK\|PLAN\):\|CLEAN')
    autocmd WinEnter,BufRead,BufNew,Syntax * hi Todo ctermfg=247 ctermbg=0
augroup END

