#! /usr/bin/env bash

ALIAS_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading aliases for bash shells"

source_submodules "${ALIAS_CONFIG_PATH}"

unset ALIAS_CONFIG_PATH
