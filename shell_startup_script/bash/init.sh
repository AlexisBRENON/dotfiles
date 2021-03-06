#! /usr/bin/env bash

SHELL_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading configuration for Bash"

# Load host specific configuration 
config_file="${SHELL_CONFIG_PATH}/host/${HOST}.sh"
source_file "$config_file" || INFO "No configuration file for host '${HOST}'"

source_file "${SHELL_CONFIG_PATH}/environment/init.sh"
source_file "${SHELL_CONFIG_PATH}/alias/init.sh"
source_file "${SHELL_CONFIG_PATH}/completion/init.sh"

source_file "${SHELL_CONFIG_PATH}/plugin/init.sh"

unset SHELL_CONFIG_PATH

