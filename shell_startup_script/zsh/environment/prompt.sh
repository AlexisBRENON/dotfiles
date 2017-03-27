#! /usr/bin/env zsh

fpath=("${HOME}/.config/shell/zsh/prompt" $fpath)
autoload -Uz promptinit
promptinit
prompt alexis
