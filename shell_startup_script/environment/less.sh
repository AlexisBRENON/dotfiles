#! /bin/sh

INFO "Setting LESS environment variables"

# Display more info in the less prompt
export LESS="$LESS -RM"
DEBUG "LESS: $LESS"

# Apply same kind of prompt to man
export MANLESS="Manual page \$MAN_PN ?ltlines %lt-%lb?L/%L.:byte %bB?s/%s. .?e(END):?pB%pB\%.. (press h for help or q to quit)"
DEBUG "MANLESS: $MANLESS"
