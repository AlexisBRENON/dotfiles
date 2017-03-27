#! /bin/sh

export HISTFILE="${HOME}/.cache/shell/history"
[ -w "${HISTFILE}" ] || (mkdir -p "$(dirname "${HISTFILE}")" 2>/dev/null ; touch "${HISTFILE}")
export HISTSIZE=1000
export HISTCONTROL="ignoreboth:erasedups"
export HISTIGNORE="ls:l:la:rm *:cd:cd ..:fg:bg"
