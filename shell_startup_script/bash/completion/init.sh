#! /usr/bin/env bash

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading custom completion for Bash."

source_submodules "${ENV_CONFIG_PATH}"

