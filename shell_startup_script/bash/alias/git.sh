#! /usr/bin/env bash

if [ -r /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git

  if type -p __git_complete ; then
    while read -r git_alias_def; do
      git_alias=$(echo "${git_alias_def}" | cut -d' ' -f1)
      git_command=$(echo "${git_alias_def}" | cut -d' ' -f3)
      git_command=$([ "$(echo "${git_command}" | cut -c1)" = "-" ] && echo "" || echo "${git_command}")
      if [ -n "${git_command}" ]; then
        __git_complete "${git_alias}" "_git_${git_command}"
      else
        __git_complete "${git_alias}" "_git_main"
      fi
    done < <(\
      alias |\
      sed -Ee 's/alias ([^=]*)=(.)(.*)\2/\1 \3/' |\
      grep "^[^ ]* git[-a-z ]*$"\
      )
  fi
fi
