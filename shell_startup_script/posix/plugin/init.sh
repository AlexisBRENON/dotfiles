#! /bin/sh

PLUGIN_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading plugins for generic shells"

load_plugin() {
    plugin_name="${1:-}"
    if [ -e "${PLUGIN_CONFIG_PATH}/${plugin_name}/${plugin_name}.sh" ]; then
        source_file "${PLUGIN_CONFIG_PATH}/${plugin_name}/${plugin_name}.sh"
    elif [ -e "${PLUGIN_CONFIG_PATH}/${plugin_name}/init.sh" ]; then
        source_file "${PLUGIN_CONFIG_PATH}/${plugin_name}/init.sh"
    else
        WARN "Plugin '${plugin_name}' unavailable."
    fi
    unset plugin_name
}

unset PLUGIN_CONFIG_PATH
