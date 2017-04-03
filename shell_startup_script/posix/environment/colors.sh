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

# Normal Colors
export Black="${ColorFontCode}0m"        # Black
export Red="${ColorFontCode}1m"          # Red
export Green="${ColorFontCode}2m"        # Green
export Yellow="${ColorFontCode}3m"       # Yellow
export Blue="${ColorFontCode}4m"         # Blue
export Purple="${ColorFontCode}5m"       # Purple
export Cyan="${ColorFontCode}6m"         # Cyan
export White="${ColorFontCode}7m"        # White

# Bold/Bright
export BBlack="${ColorFontCode}8m"       # Grey
export BRed="${ColorFontCode}9m"         # Red
export BGreen="${ColorFontCode}10m"       # Green
export BYellow="${ColorFontCode}11m"      # Yellow
export BBlue="${ColorFontCode}12m"        # Blue
export BPurple="${ColorFontCode}13m"      # Purple
export BCyan="${ColorFontCode}14m"        # Cyan
export BWhite="${ColorFontCode}15m"       # White

export Default="${ColorFontCode}m"

# Background
export On_Black="${ColorBackCode}0m"       # Black
export On_Red="${ColorBackCode}1m"         # Red
export On_Green="${ColorBackCode}2m"       # Green
export On_Yellow="${ColorBackCode}3m"      # Yellow
export On_Blue="${ColorBackCode}4m"        # Blue
export On_Purple="${ColorBackCode}5m"      # Purple
export On_Cyan="${ColorBackCode}6m"        # Cyan
export On_White="${ColorBackCode}7m"       # White

export On_Default="${ColorBackCode}m"

export ColorReset="\e[m"       # Color Reset
