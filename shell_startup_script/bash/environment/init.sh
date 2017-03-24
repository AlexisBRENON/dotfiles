#! /usr/bin/env bash

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for Zsh."

source_file "${ENV_CONFIG_PATH}/options.sh"
source_file "${ENV_CONFIG_PATH}/history.sh"
source_file "${ENV_CONFIG_PATH}/prompt.sh"
source_file "${ENV_CONFIG_PATH}/completion.sh"

unset ENV_CONFIG_PATH
