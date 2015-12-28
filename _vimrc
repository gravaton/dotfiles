" This is a UTF-8 script
scriptencoding utf-8

" Run Vundle if our VIM version permits it - if not, we're on our own
if v:version > 703
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
  else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
  endif
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " Tabular
  Plugin 'godlygeek/tabular'

  " lightline
  Plugin 'itchyny/lightline.vim'

  " NERDTree
  Plugin 'scrooloose/nerdtree'

  " Fugitive.vim
  Plugin 'tpope/vim-fugitive'

  " solarized colors
  Plugin 'altercation/Vim-colors-solarized'

  " Better Javascript comprehension
  Plugin 'pangloss/vim-javascript'

  " Bufferline
  Plugin 'bling/vim-bufferline'

  " CtrlP - Maybe Unite one day?
  Plugin 'kien/ctrlp.vim'

  " Vim-surround
  Plugin 'tpope/vim-surround.git'

  " Keep Plugin commands between vundle#begin/end.

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
  " To ignore plugin indent changes, instead use:
  "filetype plugin on
  "
  " Brief help
  " :PluginList       - lists configured plugins
  " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
  " :PluginSearch foo - searches for foo; append `!` to refresh local cache
  " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
  "
  " see :h vundle for more details or wiki for FAQ
  " Put your non-Plugin stuff after this line
  "
endif

" File encodings and UTF-8
set encoding=utf-8

" Windows stuff!
if has("win32")
	source $VIMRUNTIME/mswin.vim

    " Save swap files in the temp directory
    set swapfile
    set dir=%TMP%

	behave mswin
	if has("gui")
        " Definitely need a nice font tho
		set guifont=Cousine:h11,Consolas:h11
	endif
endif

" Generic GUI stuff
if has("gui")
    " Ain't need no toolbar
    set guioptions-=T
    " Ain't need no scrollbars
    set guioptions-=r
    set guioptions-=L
    " Set tab labels to be overridable
    set guitablabel=%{exists('t:guilabel')?t:guilabel\ :''}
endif

" Buffers
set hidden

" Turn on line numbers and cursor line hilighting
set number
set cursorline

" Deal with colorizing
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  " Enable syntax hilighting
  syntax enable
  set omnifunc=syntaxcomplete#Complete
  " Enable search result jumpto (Off for now) and hilighting
  " set incsearch
  set hlsearch
endif

" Disable bufferline echoing
let g:bufferline_echo = 0

" Configure Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified',
      \               'bufferline' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \ },
      \ 'component_visible_condition': {
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \}

" Enable statusline
set noshowmode
set laststatus=2

" Set tabs to be something sane
set tabstop=4
set shiftwidth=4
set expandtab

" Show tabs and trailing spaces
set listchars=tab:»·,trail:·

" Code folding if enabled
if has('folding')
  set foldenable
  set foldlevelstart=10
  set foldnestmax=10
  set foldmethod=syntax
  " Remap space to open and close folds
  nnoremap <space> za
endif

" Custom foldtext because the default is meh
function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()

" Javascript concealers
let g:javascript_conceal_function   = "."
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "?"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "N"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "."
let g:javascript_conceal_super      = "O"


" Enable solarized colorscheme if available
try
  set background=dark
  if !has("gui_running")
    let g:solarized_termcolors=256
  endif
  silent! colorscheme solarized
catch
  colorscheme torte
endtry

" Enable nice tab completion menu if enabled
if has('wildmenu')
  set wildmenu
endif
