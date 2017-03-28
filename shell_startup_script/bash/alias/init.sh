#! /usr/bin/env bash

ALIAS_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading aliases for bash shells"

source_file "${ALIAS_CONFIG_PATH}/git.sh"
