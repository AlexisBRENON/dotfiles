#! /usr/bin/env zsh

ALIAS_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading aliases for generic Zsh"

source_file "${ALIAS_CONFIG_PATH}/trailing.sh"

unset ALIAS_CONFIG_PATH
