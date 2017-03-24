#! /usr/bin/env bash

SHELL_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading configuration for Bash"

source_file "${SHELL_CONFIG_PATH}/environment/init.sh"

# Load host specific configuration 
config_file="${SHELL_CONFIG_PATH}/host/${HOST}.sh"
source_file "$config_file" || INFO "No configuration file for host '${HOST}'"

source_file "${SHELL_CONFIG_PATH}/plugin/init.sh"

unset SHELL_CONFIG_PATH

