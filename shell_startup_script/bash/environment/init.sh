#! /usr/bin/env bash

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for Bash."

source_submodules "${ENV_CONFIG_PATH}"

unset ENV_CONFIG_PATH
