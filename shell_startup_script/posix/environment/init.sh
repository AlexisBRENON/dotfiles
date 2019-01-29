#! /bin/sh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for generic shell."

export WORDCHARS=""
export EDITOR="vim"

source_submodules "${ENV_CONFIG_PATH}"

unset ENV_CONFIG_PATH
