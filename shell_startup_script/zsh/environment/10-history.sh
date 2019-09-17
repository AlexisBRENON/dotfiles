#! /usr/bin/env zsh

export SAVEHIST="${HISTSIZE}"
export HISTORY_IGNORE="($(echo "${HISTIGNORE}" | sed 's/:/|/g'))"

setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups # Doesn't print duplicates when searching history
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history



