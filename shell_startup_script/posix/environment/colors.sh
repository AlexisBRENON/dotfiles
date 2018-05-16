#! /usr/bin/env bash

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

colors_example() {
  #
  # generates an 8 bit color table (256 colors) for
  # reference purposes, using the \033[48;5;${val}m
  # ANSI CSI+SGR (see "ANSI Code" on Wikipedia)
  #
  echo -en "\n   +  "
  for i in {0..35}; do
    printf "%2b " $i
  done

  printf "\n\n %3b  " 0
  for i in {0..15}; do
    echo -en "\033[48;5;${i}m  \033[m "
  done

  #for i in 16 52 88 124 160 196 232; do
  for i in {0..6}; do
    let "i = i*36 +16"
    printf "\n\n %3b  " $i
    for j in {0..35}; do
      let "val = i+j"
      echo -en "\033[48;5;${val}m  \033[m "
    done
  done

  echo -e "\n"
}

export ColorFontCode='\e[38;5;'
export ColorBackCode='\e[48;5;'
export ColorEndCode='m'

# Normal Colors
export Black="${ColorFontCode}0${ColorEndCode}"        # Black
export Red="${ColorFontCode}1${ColorEndCode}"          # Red
export Green="${ColorFontCode}2${ColorEndCode}"        # Green
export Yellow="${ColorFontCode}3${ColorEndCode}"       # Yellow
export Blue="${ColorFontCode}4${ColorEndCode}"         # Blue
export Purple="${ColorFontCode}5${ColorEndCode}"       # Purple
export Cyan="${ColorFontCode}6${ColorEndCode}"         # Cyan
export White="${ColorFontCode}7${ColorEndCode}"        # White

# Bold/Bright
export BBlack="${ColorFontCode}8${ColorEndCode}"       # Grey
export BRed="${ColorFontCode}9${ColorEndCode}"         # Red
export BGreen="${ColorFontCode}10${ColorEndCode}"       # Green
export BYellow="${ColorFontCode}11${ColorEndCode}"      # Yellow
export BBlue="${ColorFontCode}12${ColorEndCode}"        # Blue
export BPurple="${ColorFontCode}13${ColorEndCode}"      # Purple
export BCyan="${ColorFontCode}14${ColorEndCode}"        # Cyan
export BWhite="${ColorFontCode}15${ColorEndCode}"       # White

export Default="${ColorFontCode}${ColorEndCode}"

# Background
export On_Black="${ColorBackCode}0${ColorEndCode}"       # Black
export On_Red="${ColorBackCode}1${ColorEndCode}"         # Red
export On_Green="${ColorBackCode}2${ColorEndCode}"       # Green
export On_Yellow="${ColorBackCode}3${ColorEndCode}"      # Yellow
export On_Blue="${ColorBackCode}4${ColorEndCode}"        # Blue
export On_Purple="${ColorBackCode}5${ColorEndCode}"      # Purple
export On_Cyan="${ColorBackCode}6${ColorEndCode}"        # Cyan
export On_White="${ColorBackCode}7${ColorEndCode}"       # White

export On_Default="${ColorBackCode}${ColorEndCode}"

export ColorReset="\e[${ColorEndCode}"       # Color Reset
