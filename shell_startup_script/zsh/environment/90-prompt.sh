#! /usr/bin/env zsh

SPACESHIP_PROMPT_ORDER=(
  gbg
  venv
  user host dir
  char
)
SPACESHIP_RPROMPT_ORDER=(
  jobs
  exec_time
  time
)
if [[ "${SNAP_NAME}" == "intellij-idea-community" ]]; then
  SPACESHIP_RPROMPT_ORDER=()
fi

SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_DEFAULT_PREFIX=$'\u2063'
SPACESHIP_PROMPT_DEFAULT_SUFFIX=$'\u2063'

SPACESHIP_GBG_SHOW=true
SPACESHIP_TIME_SHOW=true

SPACESHIP_USER_SUFFIX=$'\u2063'
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=" "

SPACESHIP_DIR_PREFIX=$'\u2063'
SPACESHIP_DIR_LOCK_SYMBOL=" $fa_lock "
SPACESHIP_DIR_SUFFIX="\n${SPACESHIP_PROMPT_DEFAULT_SUFFIX}"

SPACESHIP_VENV_SYMBOL=" ${mfizz_python}  "
SPACESHIP_VENV_SUFFIX=" \n${SPACESHIP_PROMPT_DEFAULT_SUFFIX}"
SPACESHIP_VENV_COLOR_FG="green"

SPACESHIP_CHAR_SYMBOL_SUCCESS="%{✨ %2G%}"
SPACESHIP_CHAR_SYMBOL_FAILURE="%{💩 %2G%}"
SPACESHIP_CHAR_SYMBOL_SECONDARY="➜ "
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_COLOR_SUCCESS="yellow"
SPACESHIP_CHAR_COLOR_FAILURE="94"

SPACESHIP_JOBS_SYMBOL="${oct_gear} "
SPACESHIP_JOBS_SUFFIX=" "

SPACESHIP_EXEC_TIME_SUFFIX=" ${md_timer}  "

SPACESHIP_TIME_PREFIX=$'\u2063'
SPACESHIP_TIME_SUFFIX=" ${oct_clock} ${SPACESHIP_PROMPT_DEFAULT_SUFFIX}"


fpath=("${HOME}/.config/shell/posix/plugin/prompt_alexis" "${HOME}/.config/shell/zsh/fpath" $fpath)
autoload -Uz promptinit
promptinit
prompt spaceship
