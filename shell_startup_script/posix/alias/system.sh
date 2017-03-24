#! /bin/sh

# ls command
alias ls="ls --color=tty" # Activate colors for interactive shells
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable

# rm command
alias rm='rm -i'

# cp command
alias cp='cp -i'

# mv command
alias mv='mv -i'

# grep command
alias grep='grep --color'

# find command
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# du/df commands
alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

