#! /bin/sh

TRACE_ENABLED="false"
DEBUG() { :; }
INFO() { :; }
WARN() { echo "$@" >&2; }
case $RC_DEBUG in
  5|trace)
    TRACE_ENABLED="true"
    DEBUG() { echo "$@" >&2; }
    INFO() { echo "$@"; }
    DEBUG "rc debug mode: TRACE"
    ;;
  4|debug|true)
    DEBUG() { echo "$@" >&2; }
    INFO() { echo "$@"; }
    DEBUG "rc debug mode: DEBUG"
    ;;
  3|2|1|info)
    INFO() { echo "$@"; }
    INFO "rc debug mode: INFO"
    ;;
  0)
    WARN() { :; }
esac

source_file() {
  set +x
  if [ -r "$1" ]; then
    DEBUG "Sourcing '$1'"
    export RC_SOURCED_FILE="$1"
    if [ "$TRACE_ENABLED" = "true" ]; then set -x; fi
    . "$1"
    set +x
    unset RC_SOURCED_FILE
    return 0
  else
    DEBUG "'$1' file not found"
    if [ "$TRACE_ENABLED" = "true" ]; then set -x; fi
    return 1
  fi
}

source_submodules() {
  set +x
  for FILE in "${1}/"*; do
    if [ -f "${FILE}" ] && [ "$(basename $FILE)" != "init.sh" ]; then
      source_file "${FILE}"
    fi
  done
}


# Load generic configuration
source_file "${HOME}/.config/shell/posix/init.sh"

# Load shell specific configuration

# We cannot rely on the SHELL value which is not update when launching a different shell
STARTING_SHELL=""
if [ -n "${BASH}" ]; then STARTING_SHELL="$(basename "${BASH}")"
elif [ -n "${ZSH_NAME}" ]; then STARTING_SHELL="${ZSH_NAME}"
else STARTING_SHELL="$(basename "${SHELL}")"
fi

config_file=$(ls "${HOME}/.config/shell/${STARTING_SHELL}/init.sh" 2> /dev/null)
source_file "$config_file" || INFO "No configuration file for shell '${SHELL}'"

unset STARTING_SHELL
unset config_file
unset source_submodules
unset source_file

INFO "Done."

