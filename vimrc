set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim' " Vim bundle manager
Plugin 'sickill/vim-monokai' " Color scheme
Plugin 'scrooloose/nerdtree' " Vim filesystem explorer
Plugin 'scrooloose/syntastic' " Vim syntax checker
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'tpope/vim-surround' " Easy surrounding
Plugin 'coot/CRDispatcher' " Requirement for EnchantedVim
Plugin 'coot/EnchantedVim' " Persistent very magic regex
Plugin 'Valloric/YouCompleteMe' " Autocomplete plugin
Plugin 'Indent-Finder' " Automatic indentation detection
Plugin 'vim-airline/vim-airline' " Improved status line
Plugin 'denilsonsa/vim-emoji-complete' " Find and insert emojis
Plugin 'udalov/kotlin-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cursorline " Highlight the current line

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set relativenumber " Display relative line number
set number " Except for the current line

syntax enable " Enable syntax highlight
set synmaxcol=1000 " Don't try to highlight very (very) long lines

" Define colorscheme
colorscheme monokai
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set go=mae

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
" Space, Tab, Indent and Wrap related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indentation
set expandtab " Use spaces instead of tabs
set tabstop=2 shiftwidth=2 " 1 tab = 2 spaces
set ai " Auto indent
set si " Smart indent

autocmd Filetype sh setlocal ts=4 sts=4 sw=4

" Line break on 100 characters
set wrap " Wrap lines
set lbr " Wrap on word boundaries

" Map arrow keys to behave on displayed line
map <special><S-Up> gk
map <special><S-Down> gj
imap <special><S-Up> <ESC>gka
imap <special><S-Down> <ESC>gja

set listchars=tab:▸·,trail:·,nbsp:␣
set list

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
" Mappings & Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easy insertion of HTML escape codes
imap <special><C-Space> &nbsp;
imap <special><C-&> &amp;

" Easy edition/reloading of my vim rc
command! Vv vs $MYVIMRC
command! Sv source $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE
let g:ale_command_wrapper = "env -i HOME=\"${HOME}\" TERM=\"${TERM}\" PATH=\"${PATH}\" ANDROID_NDK=\"${ANDROID_NDK}\" ANDROID_HOME=\"${ANDROID_HOME}\" GCC_ARM_TOOLCHAIN=\"${GCC_ARM_TOOLCHAIN}\""

" EnchantedVim

let g:VeryMagic = 0 " Disable EnchantedVim for incsearch
" Define two mappings to enable magic regex during search
nm / /\v
nm ? ?\v
let g:VeryMagicSubstitute = 1 " Magic regex for substitution

" Syntastic
let g:syntastic_sh_checkers = ["shellcheck", "bashate", "sh"]
let g:syntastic_sh_shellcheck_args = "-x"

let g:syntastic_cpp_compiler_options = "-std=c++11"

" NERDTree

" Press F2 to toggle the NERDTree pane
map <silent><F2> :NERDTreeToggle<CR>

" Vim-Pandoc
let g:pandoc#modules#disabled = ["chdir"]

" LanguageTool
let g:languagetool_jar = '/usr/bin/languagetool'
let g:languagetool_disable_rules = 'WHITESPACE_RULE,FRENCH_WHITESPACE,COMMA_PARENTHESIS_WHITESPACE'
map <silent><F12> :LanguageToolCheck<CR>

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
