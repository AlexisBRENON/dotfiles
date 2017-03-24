#! /bin/sh

ALIAS_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading aliases for generic shells"

source_file "${ALIAS_CONFIG_PATH}/system.sh"
source_file "${ALIAS_CONFIG_PATH}/archive.sh"
source_file "${ALIAS_CONFIG_PATH}/rsync.sh"
source_file "${ALIAS_CONFIG_PATH}/git.sh"
source_file "${ALIAS_CONFIG_PATH}/misc.sh"

# TODO: merge these aliases
source_file "${ALIAS_CONFIG_PATH}/apt-get.sh"
source_file "${ALIAS_CONFIG_PATH}/pacman.sh"
source_file "${ALIAS_CONFIG_PATH}/yahourt.sh"

unset ALIAS_CONFIG_PATH
