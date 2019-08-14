#! /bin/sh

icons_in_terminal_dir="${HOME}/.local/share/icons-in-terminal"
if [ -d "${icons_in_terminal_dir}" ]; then
    . ${icons_in_terminal_dir}/icons_bash.sh
else
    WARN "Icons in terminal is not available."
fi

unset icons_in_terminal_dir
