#! /bin/sh

ALIAS_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading aliases for generic shells"

source_file "${ALIAS_CONFIG_PATH}/system.sh"
source_file "${ALIAS_CONFIG_PATH}/archive.sh"
source_file "${ALIAS_CONFIG_PATH}/rsync.sh"
source_file "${ALIAS_CONFIG_PATH}/git.sh"
source_file "${ALIAS_CONFIG_PATH}/misc.sh"
source_file "${ALIAS_CONFIG_PATH}/python.sh"
source_file "${ALIAS_CONFIG_PATH}/vlc.sh"
source_file "${ALIAS_CONFIG_PATH}/package-manager.sh"
source_file "${ALIAS_CONFIG_PATH}/docker.sh"

unset ALIAS_CONFIG_PATH
