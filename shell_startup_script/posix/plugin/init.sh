#! /bin/sh

PLUGIN_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading plugins for generic shells"

source_file "${PLUGIN_CONFIG_PATH}/god-bless-git/init.sh"

unset PLUGIN_CONFIG_PATH
