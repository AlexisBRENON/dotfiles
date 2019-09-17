#! /usr/bin/env zsh

COMPLETION_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading custom completion for Zsh."

fpath=("${COMPLETION_CONFIG_PATH}" $fpath)


