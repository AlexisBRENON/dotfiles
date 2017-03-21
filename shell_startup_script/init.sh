#! /bin/sh

DEBUG() { :; }
INFO() { :; }
case $RC_DEBUG in
    5|4|debug)
        echo "rc debug mode: DEBUG"
        DEBUG() { echo "$@" >&2; }
        INFO() { echo "$@"; }
        ;;
    3|2|1|info)
        echo "rc debug mode: INFO"
        INFO() { echo "$@"; }
        ;;
esac


#HIST_STAMPS="yyyy-mm-dd"

#plugins=($distrib common-aliases extract git sudo taskwarrior)

# Define the environment
if [ -r "${HOME}/.config/shell/environment/init.sh" ]; then
  INFO "Defining environment variables"
  . "${HOME}/.config/shell/environment/init.sh"
fi
# Define the aliases
if [ -r "${HOME}/.config/shell/alias/init.sh" ]; then
  INFO "Defining aliases"
  . "${HOME}/.config/shell/alias/init.sh"
fi

# Load shell specific configuration
config_file=$(ls "${HOME}/.config/shell/shell-type/$(basename "${SHELL}")/init.sh" 2> /dev/null)
if [ -r "${config_file}" ]; then
  INFO "Sourcing '${config_file}'"
  . "${config_file}"
else
  INFO "No configuration file for shell '${SHELL}'"
fi

# Load host specific configuration 
config_file=$(ls "${HOME}/.config/shell/host/${HOST}/init.sh" 2> /dev/null)
if [ -r "${config_file}" ]; then
  INFO "Sourcing '${config_file}'"
  . "${config_file}"
else
  INFO "No configuration file for host '${HOST}'"
fi

# Load plugins
if [ -r "${HOME}/.config/shell/plugins/init.sh" ]; then
  INFO "Loading plugins"
  . "${HOME}/.config/shell/plugins/init.sh"
fi
# TODO : move this to plugin/init.sh
if [ -r "${HOME}/.config/shell/plugins/god-bless-git/init.sh" ] ; then
  . "${HOME}/.config/shell/plugins/god-bless-git/init.sh"
fi

  #zgen prezto archive
  #zgen prezto completion
#  zgen prezto git 
  #zgen prezto history-substring-search
#  zgen prezto pacman
  #zgen prezto rsync
  #zgen prezto utility

# User configuration
#

INFO "Done."
