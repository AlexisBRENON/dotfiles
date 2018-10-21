#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage:
#/ Description:
#/ Examples:
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { printf "[INFO]    %s" "$*" | tee -a "$LOG_FILE" >&2 ; }
warning() { printf "[WARNING] %s" "$*" | tee -a "$LOG_FILE" >&2 ; }
error()   { printf "[ERROR]   %s" "$*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { printf "[FATAL]   %s" "$*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    # ...
fi
