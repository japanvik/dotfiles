" ------------------------------
" Vik's vimrc
" Heavily inspired by Martin Brochhaus'
" PyCon APAC 2012 talk
" ------------------------------

" Vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" ------------------------------
" Plugin Defs
" ------------------------------
"Plugin 'gmarik/vundle'

Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'csv.vim'
Plugin 'pangloss/vim-javascript'

" ------------------------------
" General Settings
" ------------------------------
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
set clipboard=unnamed

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Rebind <Leader> key
let mapleader = ","

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

"Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" bind Ctrl+<movement> keys to move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
"map <Leader>n <esc>:tabprevious<CR>
"map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code
" here and then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color Scheme
color molokai

" Syntax highlighting
filetype plugin indent on
syntax on

"set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"Use Unix as the standard file type
set ffs=unix,dos,mac

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove smart indent for # for Python
au! FileType python setl nosmartindent

" Buffer execution for python
au! FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" Buffer execution for Javascript (using Node)
au! FileType javascript nnoremap <buffer> <F5> :exec '!node' shellescape(@%, 1)<cr>

" Autodetects for CSV files
au BufRead,BufNewFile *.csv,*.dat,*.tsv,*.tab set filetype=csv


" ------------------------------
" => Visual mode related
" ------------------------------

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Close the current buffer
map <leader>bd :bdelete<cr>


" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Navigate through buffers
:nnoremap <leader>m <esc>:bnext<CR>
:nnoremap <leader>n <esc>:bprevious<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
"set colorcolumn=80
"highlight ColorColumn ctermbg=242

" absolute line numbers in insert mode, relative otherwise for easy movement
au InsertEnter * :set nu
au InsertLeave * :set rnu

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Easier inc / dec
nnoremap + <C-a>
nnoremap - <C-x>

" Move cursor in insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

" Useful settings
set history=700
set undolevels=700

" Use spaces instead of tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


" ------------------------------
"  Plugin Config
" ------------------------------

" bling/vim-airline
"let g:airline#extensions#tabline#enabled = 1
" enable/disable syntastic integration >
let g:airline#extensions#syntastic#enabled = 1
" enable/disable csv integration for displaying the current column. >
let g:airline#extensions#csv#enabled = 1
" change how columns are displayed. >
" let g:airline#extensions#csv#column_display = 'Number'
let g:airline#extensions#csv#column_display = 'Name'
" enable/disable bufferline integration >
let g:airline#extensions#bufferline#enabled = 1
" determine whether bufferline will overwrite customization variables >
let g:airline#extensions#bufferline#overwrite_variables = 1
" the symbol to denote that a buffer is modified
let g:bufferline_modified = '*'

set laststatus=2

" kien/ctrlp.vim
let g:ctrlp_max_height = 10
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" SirVer/ultisnips
" honza/vim-snippets

" Valloric/YouCompleteMe
" Make UltiSnip work well with YCM
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" davidhalter/jedi-vim

" Python folding
" http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" heavenshell/vim-pydocstring
nmap <silent> <leader>l <Plug>(pydocstring)

" Syntatstic


