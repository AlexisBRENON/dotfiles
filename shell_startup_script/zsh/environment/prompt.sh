#! /usr/bin/env zsh

fpath=(/home/alexis/.config/shell/zsh/prompt $fpath)
autoload -Uz promptinit
promptinit
prompt alexis
