#! /usr/bin/env zsh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for Zsh."

source_file "${ENV_CONFIG_PATH}/options.sh"
source_file "${ENV_CONFIG_PATH}/history.sh"
source_file "${ENV_CONFIG_PATH}/bindkey.sh"
source_file "${ENV_CONFIG_PATH}/completion.sh"
source_file "${ENV_CONFIG_PATH}/prompt.sh"

unset ENV_CONFIG_PATH
