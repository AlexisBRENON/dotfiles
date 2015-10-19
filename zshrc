case $ZSHRC_DEBUG in
    5|4)
        echo "zshrc debug mode: DEBUG"
        export DEBUG=echo
        export INFO=echo
        ;;
    3|2|1)
        echo "zshrc debug mode: INFO"
        export DEBUG=true
        export INFO=echo
        ;;
    *)
        export DEBUG=true
        export INFO=true
        ;;
esac

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="AlexisBRENON"
$INFO "ZSH_THEME set: $ZSH_THEME"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
local distrib=$(cat /etc/os-release | grep -i -e "ID_LIKE")
if [[ -z $distrib ]]
  then
  distrib=$(cat /etc/os-release | grep -i -e "ID")
fi
distrib=$(echo $distrib | cut -d= -f2)
$DEBUG "Fetch distrib from 'os-release': $distrib"
case $distrib in
  debian)
  # Nothing to do
  ;;
  arch)
    distrib=archlinux
    ;;
  *)
    distrib=""
    ;;
esac
$INFO "Normalized distrib: $distrib"

plugins=($distrib common-aliases extract git sudo taskwarrior)
$INFO "plugins:"
$INFO "  $plugins" | sed 's/\b /\n  /g'


# User configuration
#

  # Add your own bin/ folders to PATH
if [[ $(hostname) = BRENON-DELL ]]
then
    PATH="$PATH"
fi
export PATH
$INFO "PATH:"
$INFO "  $PATH" | sed 's/:/\n  /g'

# Host dependant configuration
if [[ $(hostname) = BRENON-DELL ]]
then
    $INFO "Custom configuration for my personal laptop"
    # Add luarocks lib to luapath
    export LUA_PATH='/home/alexis/.luarocks/share/lua/5.3/?.lua;/home/alexis/.luarocks/share/lua/5.3/?/init.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua'
    export LUA_CPATH='/home/alexis/.luarocks/lib/lua/5.3/?.so;/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so'

    # Make termite support LS_COLOR
    eval $(dircolors ~/.dircolors 2>/dev/null)
fi

# Load Oh-my-zsh
$INFO "Load Oh-My-Zsh..."
source $ZSH/oh-my-zsh.sh
$INFO "Done"

