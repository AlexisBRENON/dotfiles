set nocompatible



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim' " Vim bundle manager
Plugin 'scrooloose/nerdtree' " Vim filesystem explorer
Plugin 'scrooloose/syntastic' " Vim syntax checker
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'tpope/vim-surround' " Easy surrounding
Plugin 'sickill/vim-monokai' " Color scheme
Plugin 'coot/CRDispatcher' " Requirement for EnchantedVim
Plugin 'coot/EnchantedVim' " Persistent very magic regex
Plugin 'Valloric/YouCompleteMe' " Autocomplete plugin
Plugin 'kchmck/vim-coffee-script' " CoffeScript support
Plugin 'Indent-Finder' " Automatic indentation detection

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Define colorscheme
colorscheme monokai

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Enable syntax highlight
syntax enable

" Color scheme
set background=dark

" Display more info in command bar
set showcmd

" Highlight the current line
set cursorline

" Display line number
set nu



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding, Platform Dependant Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure backspace
set backspace=eol,start,indent

" Define encoding
set encoding=utf-8

" Use UNIX as the std file type
set ffs=unix



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab, Indent and Wrap related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indentation
set expandtab " Use spaces instead of tabs
set tabstop=2 shiftwidth=2 " 1 tab = 2 spaces
set ai " Auto indent
set si " Smart indent

" Line break on 100 characters
set wrap " Wrap lines
set lbr " Wrap on word boundaries

" Map arrow keys to behave on displayed line
map <special><S-Up> gk
map <special><S-Down> gj
imap <special><S-Up> <ESC>gka
imap <special><S-Down> <ESC>gja

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch " Highlight matchings
set incsearch " Search during typing
set ignorecase " Search are case insensitive...
set smartcase " ... except if the search contains upper case
" Hide highlight when pressing ^L
nnoremap <C-L> :nohl<CR><C-L>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easy insertion of HTML escape codes
imap <special><C-Space> &nbsp;
imap <special><C-&> &amp;

" Easy edition/reloading of my vim rc
cmap vv vs $MYVIMRC<CR>
cmap sv source $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" EnchantedVim

let g:VeryMagic = 0 " Disable EnchantedVim for incsearch
" Define two mappings to enable magic regex during search
nm / /\v
nm ? ?\v
let g:VeryMagicSubstitute = 1 " Magic regex for substitution

" NERDTree

" Press F2 to toggle the NERDTree pane
map <silent><F2> :NERDTreeToggle<CR>
map! <silent><F2> :NERDTreeToggle<CR>


