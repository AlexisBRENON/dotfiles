case $ZSHRC_DEBUG in
    5|4|debug)
        echo "zshrc debug mode: DEBUG"
        export DEBUG=echo
        export INFO=echo
        ;;
    3|2|1|info)
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

# Identify the current distribution
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
  arch*)
    distrib=archlinux
    ;;
  *)
    distrib=""
    ;;
esac
$INFO "Normalized distrib: $distrib"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=($distrib common-aliases extract git sudo taskwarrior)
$INFO "plugins:"
$INFO "  $plugins" | sed 's/\b /\n  /g'

# Load Oh-my-zsh
$INFO "Load Oh-My-Zsh..."
source $ZSH/oh-my-zsh.sh
$INFO "Done"

# User configuration
#
$INFO "User configuration..."
  # Display more info in the less prompt
export LESS="$LESS -M"
$DEBUG "LESS: $LESS"
  # Apply same kind of prompt to man
export MANLESS="Manual page \$MAN_PN ?ltlines %lt-%lb?L/%L.:byte %bB?s/%s. .?e(END):?pB%pB\%.. (press h for help or q to quit)"
$DEBUG "MANLESS: $MANLESS"

# Host dependant configuration
if [[ $(hostname) = BRENON-DELL ]]
then
    $INFO "Custom configuration for my personal laptop"

    # Add luarocks lib to luapath
    export LUA_PATH=${HOME}'/.luarocks/share/lua/5.3/?.lua;'${HOME}'/.luarocks/share/lua/5.3/?/init.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua'
    export LUA_CPATH=${HOME}'/.luarocks/lib/lua/5.3/?.so;/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so'

    # Make termite support LS_COLOR
    eval $(dircolors ~/.dircolors 2>/dev/null)

    # added by travis gem
    [ -f /home/alexis/.travis/travis.sh ] && source /home/alexis/.travis/travis.sh

    . ~/Documents/Development/third_party/oh-my-git/base.sh

elif [[ $(hostname) = "hector2" ]]; then
    $INFO "Custom configuration for my hector2 computer"
    . /home/brenon/torch/install/bin/torch-activate
    export TEXMFHOME="${HOME}/.local/share/texmf"
    export PATH="/home/brenon/.local/texlive/2016/bin/x86_64-linux:${PATH}"
    export PATH="/home/brenon/.local/bin:${PATH}"
    . ~/Documents/git_repos/oh-my-git/base.sh
fi

$INFO "Done."
