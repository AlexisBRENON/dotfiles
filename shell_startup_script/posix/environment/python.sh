#! /bin/sh

if [ -e "${HOME}/.pythonrc.py" ]; then
  export PYTHONSTARTUP=$HOME/.pythonrc.py
fi

# Remove default virtual env prompt
export VIRTUAL_ENV_DISABLE_PROMPT="true"
