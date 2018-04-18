#! /usr/bin/env zsh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading custom completion for Zsh."

fpath=("${ENV_CONFIG_PATH}" $fpath)

