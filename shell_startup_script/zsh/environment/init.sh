#! /usr/bin/env zsh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for Zsh."

source_submodules "${ENV_CONFIG_PATH}"

unset ENV_CONFIG_PATH
