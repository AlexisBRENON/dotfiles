#! /bin/sh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for generic shell."

export WORDCHARS=""

source_file "${ENV_CONFIG_PATH}/history.sh"
source_file "${ENV_CONFIG_PATH}/ls.sh"
source_file "${ENV_CONFIG_PATH}/less.sh"
source_file "${ENV_CONFIG_PATH}/display.sh"
source_file "${ENV_CONFIG_PATH}/colors.sh"

unset ENV_CONFIG_PATH
