#! /usr/bin/env zsh

fpath=(/home/alexis/.config/shell/prompt $fpath)
autoload -Uz promptinit
promptinit
prompt alexis
