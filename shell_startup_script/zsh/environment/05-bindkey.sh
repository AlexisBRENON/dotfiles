#! /usr/bin/env zsh

INFO "Setting key bindings for Zsh"

zmodload zsh/terminfo

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

typeset -A key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '^[[1;5D'
  'ControlRight' '^[[1;5C'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Suppr'       "^[[3~"
  'F1'           "${terminfo[kf1]}"
  'F2'           "${terminfo[kf2]}"
  'F3'           "${terminfo[kf3]}"
  'F4'           "${terminfo[kf4]}"
  'F5'           "${terminfo[kf5]}"
  'F6'           "${terminfo[kf6]}"
  'F7'           "${terminfo[kf7]}"
  'F8'           "${terminfo[kf8]}"
  'F9'           "${terminfo[kf9]}"
  'F10'          "${terminfo[kf10]}"
  'F11'          "${terminfo[kf11]}"
  'F12'          "${terminfo[kf12]}"
  'Insert'       "${terminfo[kich1]}"
  'Home'         "${terminfo[khome]}"
  'PageUp'       "${terminfo[kpp]}"
  'End'          "${terminfo[kend]}"
  'PageDown'     "${terminfo[knp]}"
  'Up'           "${terminfo[kcuu1]}"
  'Left'         "${terminfo[kcub1]}"
  'Down'         "${terminfo[kcud1]}"
  'Right'        "${terminfo[kcuf1]}"
  'BackTab'      "${terminfo[kcbt]}"
)

bindkey -e

bindkey "${key_info[Control]}r" history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

# start typing + [Up-Arrow] - fuzzy find history forward
if [ -n "${key_info[Up]}" ]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${key_info[Up]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [ -n "${key_info[Down]}" ]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${key_info[Down]}" down-line-or-beginning-search
fi

if [ -n "${key_info[Home]}" ]; then
  bindkey "${key_info[Home]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [ -n "${key_info[End]}" ]; then
  bindkey "${key_info[End]}"  end-of-line            # [End] - Go to end of line
fi

bindkey "${key_info[ControlRight]}" forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey "${key_info[ControlLeft]}" backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [ -n "${key_info[BackTab]}" ]; then
  bindkey "${key_info[BackTab]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

if [ "${key_info[Suppr]}" ]; then
  bindkey "${key_info[Suppr]}" delete-char            # [Delete] - delete forward
fi

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "${key_info[Escape]}${key_info[Escape]}" sudo-command-line

unset key_info
