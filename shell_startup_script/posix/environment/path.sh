#! /bin/sh

if [ -d '/opt/bin' ]; then
    export PATH="/opt/bin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

