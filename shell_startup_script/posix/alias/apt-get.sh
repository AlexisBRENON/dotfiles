#! /bin/sh 


if command -v aptitude > /dev/null || command -v apt-get > /dev/null ; then

  # Use aptitude if installed, or apt-get if not.
  # You can just set apt_pref='apt-get' to override it.
  if command -v aptitude > /dev/null ; then
    apt_pref='aptitude'
    apt_upgr='safe-upgrade'
  elif command -v apt-get > /dev/null ; then
    apt_pref='apt-get'
    apt_upgr='upgrade'
  fi

  # Aliases ###################################################################

  # Some self-explanatory aliases
  alias aps="${apt_pref} search"

  # apt-file
  alias apfs='apt-file search --regexp'

  # superuser operations ######################################################
  alias aac="sudo $apt_pref autoclean"
  alias abd="sudo $apt_pref build-dep"
  alias ac="sudo $apt_pref clean"
  alias ad="sudo $apt_pref update"
  alias adg="sudo $apt_pref update && sudo $apt_pref $apt_upgr"
  alias adu="sudo $apt_pref update && sudo $apt_pref dist-upgrade"
  alias ai="sudo $apt_pref install"
  alias ar="sudo $apt_pref remove"

  # Remove ALL kernel images and headers EXCEPT the one in use
  alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) 
  ?not(~n`uname -r`))'

  # Misc. #####################################################################
  # print all installed packages
  alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

  # Prints apt history
  # Usage:
  #   apt-history install
  #   apt-history upgrade
  #   apt-history remove
  #   apt-history rollback
  #   apt-history list
  # Based On: http://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
  apt_history() {
    case "$1" in
      (install|upgrade|remove)
        zgrep --no-filename "$1" $(ls -rt /var/log/dpkg*)
        ;;
      rollback)
        zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
          grep "$2" -A10000000 | \
          grep "$3" -B10000000 | \
          awk '{print $4"="$5}'
        ;;
      list)
        zgrep --no-filename '' $(ls -rt /var/log/dpkg*)
        ;;
      *)
        echo "Parameters:"
        echo " install - Lists all packages that have been installed."
        echo " upgrade - Lists all packages that have been upgraded."
        echo " remove - Lists all packages that have been removed."
        echo " rollback - Lists rollback information."
        echo " list - Lists all contains of dpkg logs."
        ;;
    esac
  }

  # List packages by size
  function apt-list-packages {
    dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
      grep -v deinstall | \
      sort -n | \
      awk '{print $1" "$2}'
  }

  unset apt_pref
  unset apt_upgr
fi
