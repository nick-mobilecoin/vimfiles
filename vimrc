" General VIM options --------------------------{{{

let s:host_vimrc = $HOME . '/host.vimrc'
if filereadable(s:host_vimrc)
  execute 'source ' . s:host_vimrc
endif

" Make most things happy, we aren't in 1970 anymore
set nocompatible
set encoding=utf-8
let $VIMHOME=expand("<sfile>:p:h")

" Use file indentation and syntax highlighting
filetype plugin indent on
syntax enable

call plug#begin()
Plug 'kristijanhusak/cosmic_latte'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/Gundo'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
"This one has backup files put into a different directory
"Note the "//" this expands the path of the current file so that you can
"edit more than one file with the same name in different directories
set backupdir=$VIMHOME/_backup//

"This one has swap files put into a different directory
"Note the "//" this expands the path of the current file so that you can
"edit more than one file with the same name in different directories
set directory=$VIMHOME/_backup//

" Playing with undo
set undodir=$VIMHOME/_backup//
set undofile

"This turns on spell checker cause I'm horrible at spelling
set spell

"turn ruler on
set ruler

" Give recursive search down the path
set path+=**

"This is to get bash like filename completion
set wildmode=longest:full,full
set wildmenu

"prevent do you want to reload file when editing in VS
set autoread

" Treat spaces as tabs and use 4 spaces by default
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Prevent some commands from jumping back to column 0
set nostartofline

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Set up desired color theme
set background=dark
colorscheme cosmic_latte
hi Normal ctermfg=145 ctermbg=NONE guifg=#abb0c0 guibg=#202a31 guisp=NONE cterm=NONE gui=NONE

" Vertical splits go to the right instead of the default left
set splitright

" Keep 3 lines of 'context' above and below the current line when scrolling
set scrolloff=3

" allow virtual editing everywhere
set virtualedit=all

"This automatically saves the file when transitioning
"This might need to be moved to a c specific area.
"But since we are in GIT i can always go back and this
"prevents things like make not saving.
set autowrite

"This lets the wrapping wrap at a word instead of midword
set linebreak

"make *.h files be treated as C and not cpp files
let g:c_syntax_for_h=1

"Highlight trailing whitespace and tabs
let g:c_space_errors=1

" Doxygen formating
let g:load_doxygen_syntax=1
let g:doxygen_end_punctuation=''
let g:doxygen_javadoc_autobrief=0

" Line numbers on, and relative when inside of a buffer
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set relativenumber
  autocmd BufLeave,FocusLost   * set norelativenumber
augroup END

" I use tagbar to the right and the quick fix defaults to opening at the
" bottom right which is squished to nothingness.  This forces it to the bottom
" of all of my open windows
augroup quickstuff
    autocmd!
    autocmd FileType qf wincmd J
augroup END

" This makes it so that I can create fold markers with Vim's zd, zf, :fold
" commands
set foldexpr=marker
"Set up folding for this and other vim files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup clean_trailing_whitespace
    autocmd!
    autocmd FileType c,cpp,python,vim autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END
" I like 80 textwidth just looks nicer
set textwidth=80

" }}}

" Search options --------------------------{{{
"these are for doing incremental and highlighting on searching
set incsearch
set hlsearch

"case insensitive when all lower case
"if any uppercase characters then it's
"a case sensitive search
set ignorecase
set smartcase

"default to normal regex when doing searches
nnoremap / /\v
nnoremap ? ?\v
cnoremap s/ s/\v

"make double escape unhighlight searches
nnoremap <esc><esc> :nohlsearch<cr>:<esc>

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-file\ ~/.config/git/ignore
endif

" }}}

" Mapping --------------------------{{{

" Use space a the main leader
let mapleader="\<Space>"
let maplocalleader="\<cr>"

" Use jk to exit insert mode.
inoremap jk <esc>

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" Bind the up and down keys to go through the error list
" nnoremap <silent> <Up> :cprev<CR>
" nnoremap <silent> <Down> :cnext<CR>

"easier page down and up commands"
nnoremap <leader>d <c-f>
nnoremap <leader>u <c-b>

"Make it easy to squash rebases.
augroup squash
    autocmd!
    autocmd FileType gitrebase nnoremap <buffer> <localleader>s :2,$substitute/^pick\>/fixup/e\|:1substitute/^pick\>/reword/e<cr>
augroup END

" Easy editing and reloading of vimrc file
nnoremap <leader>sv :source $MYVIMRC <cr>
nnoremap <leader>ev :vsplit $MYVIMRC <cr>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

"Stamping, I don't use the S key in normal mode so
"make it useful to me
nnoremap s diw"0P
nnoremap S :%s/\<<C-r><C-w>\>/<C-r>0/g
vnoremap s "0P
"probably should change this to a function so it doesn't
"blow away some random buffer
vnoremap S "1y:%s/<C-r>1/<C-r>0/g

"grep for the current word that the cursor is on
nnoremap <localleader>f :grep! "\b<C-r><C-W>\b"<cr>:cw<cr>

" Not sure I like this mapping but quickly replace a word with the current
" buffer file name
nnoremap ci% :s/<c-r><c-w>/\=expand('%:t:r')/<cr>

" }}}

" UltiSnips options --------------------------{{{

"set up UltiSnips to work nicely with you complete me
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"

let g:UltiSnipsEditSplit='vertical'
let g:ultisnips_python_style='google'
nnoremap <leader>eu :UltiSnipsEdit<cr>
" }}}

" Tagbar settings {{{
nnoremap <leader>t :Tagbar<cr>
" Default is space which is my leader key, don't foresee a need to "undo"
" anything in the tagbar window.
let g:tagbar_map_showproto='u'

" }}}

" Light line settings {{{
" Turn on the status bar, always
set laststatus=2

" Mode is now handled by lightline
set noshowmode
" }}}

" FZF {{{
" Use the faster 'fd' command, note this has to be installed
if executable('fdfind')
    let $FZF_DEFAULT_COMMAND='fdfind --type f'
elseif executable('fd')
    let $FZF_DEFAULT_COMMAND='fd --type f'
endif

" Give CTRL-P command via FZF
 nnoremap <silent> <c-p> :Files<CR>

" }}}

" fugitive/git settings --------------------------{{{
" Going to use the 'g' prefix to signify git commands
" So basically everything will be <leader>g<something>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gm :Gvdiff origin/master<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>

" To prevent me accidentally making changes on the master branch I only
" blindly push branches if they aren't master.
" May need to update this to ignore 'development/**' and 'production/**'
nnoremap <leader>gp :call Safepush()<CR>
function! Safepush()
let l:branchname = fugitive#head()
if l:branchname ==? 'master'
    echo 'Not pushing, this is a mainline branch: "' . l:branchname . '"'
else
    execute ":Git push"
endif
endfunction
" }}}

" NERDtree settings --------------------------{{{
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

"This one closes NERDTree on normal open commands but stays open for the g*
"commands
let g:NERDTreeQuitOnOpen=1

" }}}
