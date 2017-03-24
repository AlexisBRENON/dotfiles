#! /bin/sh

_rsync_cmd() {
  if [ "$(rsync --help 2>&1 | grep --count 'xattrs')" -gt 0 ] ; then
    set -- "--acls" "--xattrs" "$@"
  fi
  set -- "--verbose" "--progress" "--human-readable" "--compress" "--archive" "--hard-links" "--one-file-system" "$@"

  rsync "$@"
}


alias rsync-copy="_rsync_cmd"
alias rsync-move="_rsync_cmd --remove-source-files"
alias rsync-update="_rsync_cmd --update"
alias rsync-synchronize="_rsync_cmd --update --delete"
