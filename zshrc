# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Use antigen to manage plugins
source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle archlinux
antigen bundle common-aliases
antigen bundle extract
antigen bundle git
antigen bundle sudo
antigen bundle taskwarrior
antigen bundle arialdomartini/oh-my-git

antigen theme arialdomartini/oh-my-git-themes oppa-lana-style

antigen-apply

# User configuration
#

  # Add your own bin/ folder to PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

  # Make termite support LS_COLOR
eval $(dircolors ~/.dircolors)

