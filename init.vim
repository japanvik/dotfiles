" ------------------------------
" Vik's config for neovim
" ------------------------------

" Functions
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction

augroup MyVimrc
  autocmd!
augroup END

" ------------------------------
" Plugin Defs
" ------------------------------
call plug#begin('~/.vim/plugged')

" Look and feel
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ianks/gruvbox'

" Completion / Editing support
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'jiangmiao/auto-pairs' " To check - not working?
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'

" Functional extensions
Plug 'kassio/neoterm'
Plug 'sjl/gundo.vim'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'

"Dev docs
Plug 'rizzatti/dash.vim'

" Python
Plug 'zchee/deoplete-jedi'
Plug 'heavenshell/vim-pydocstring'

" HTML / CSS
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'chrisgillis/vim-bootstrap3-snippets'

" Javascript
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }

call plug#end()

" Initialization
autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()

" ------------------------------
" View Settings
" ------------------------------

" Yggdroot/indentLine settings
let g:indentLine_char = '┆'
"let g:indentLine_color_term = 239


" ------------------------------
" General Settings
" ------------------------------
" Path setting to go deep in the search
" Might be better to use ctrlP?
set path+=**

" Color Scheme
set termguicolors
colorscheme gruvbox  "use the theme gruvbox
set background=dark "use the light version of gruvbox
let g:airline_theme='gruvbox'

" Syntax highlighting
filetype plugin indent on
syntax on

"set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"Use Unix as the standard file type
set ffs=unix,dos,mac

set si "Smart indent
set wrap "Wrap lines

" Rebind <Leader> key
let mapleader = ","

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Better copy & paste
set clipboard=unnamed
"set paste

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing

" absolute line numbers in insert mode, relative otherwise for easy movement
au InsertEnter * :set nu
au InsertLeave * :set rnu

"Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
noremap <C-n> :nohl<CR>

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

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code
" here and then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Tag jumping
" create tags files
" use ^] to jump to tag under cursor
" use g^] for ambiguous tags
" use ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" Nerdtree
" <F4> => popup the file tree navigation)
nmap <F4> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

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
au! FileType python inoremap # X<C-H>#

" Buffer execution for python
au! FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" Buffer execution for Javascript (using Node)
au! FileType javascript nnoremap <buffer> <F5> :exec '!node' shellescape(@%, 1)<cr>

" Autodetects for markdown files
au BufRead,BufNewFile *.md set filetype=markdown

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
map <leader>ba :% bd!<cr>

" Navigate through buffers
:nnoremap <leader>m <esc>:bnext<CR>
:nnoremap <leader>n <esc>:bprevious<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

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

" Terminal toggle Map to ESC so it's easire
tnoremap <silent> <ESC> <C-\><C-n>

" Map save
map <C-s> :w<cr>

"Useful settings
set history=700
set undolevels=700
"Incommand
set inccommand=nosplit

" Use spaces instead of tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Enable hidden buffers so we don't have to save all the time.
set hidden

" ------------------------------
"  Plugin Config
" ------------------------------

" AutoPairs
let g:AutoPairsShortcutToggle = "<leader>p"
let g:AutoPairsFlyMode = 1


" Airline
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:bufferline_modified = '*'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

set laststatus=2

" kien/ctrlp.vim
let g:ctrlp_max_height = 10
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" SirVer/ultisnips
" honza/vim-snippets

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" Adding pythonpath
let g:python2_host_prog = '/Users/vikram.kumar/python/sandbox/bin/python'

" Adding custom snippets
"let g:UltiSnipsSnippetDirectories = ['~/.vim/snips/angular-vim-snippets/UltiSnips']
let g:UltiSnipsSnippetDirectories = ['~/.local/share/nvim/site/snips']


" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Python folding
" http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" heavenshell/vim-pydocstring
nmap <silent> <leader>l <Plug>(pydocstring)

" Ansible plugin
" https://github.com/chase/vim-ansible-yaml
"let g:ansible_options = {'ignore_blank_lines': 0}
