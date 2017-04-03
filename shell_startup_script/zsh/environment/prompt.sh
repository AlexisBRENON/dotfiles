#! /usr/bin/env zsh

fpath=("${HOME}/.config/shell/posix/plugin/prompt_alexis" $fpath)
autoload -Uz promptinit
promptinit
prompt alexis
