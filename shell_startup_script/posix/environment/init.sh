#! /bin/sh

ENV_CONFIG_PATH="$(dirname "$RC_SOURCED_FILE")"

INFO "Loading environment variables for generic shell."

export WORDCHARS=""
if command -pv nvim >/dev/null; then
	EDITOR="nvim"
elif command -pv vim >/dev/null; then
	EDITOR="vim"
fi
export EDITOR

source_submodules "${ENV_CONFIG_PATH}"

unset ENV_CONFIG_PATH
