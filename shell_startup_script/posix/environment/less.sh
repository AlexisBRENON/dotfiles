#! /bin/sh

# Use less as the default pager
export PAGER=less
# Display more info in the less prompt
export LESS="$LESS -RM"
# Apply same kind of prompt to man
export MANLESS="Manual page \$MAN_PN ?ltlines %lt-%lb?L/%L.:byte %bB?s/%s. .?e(END):?pB%pB\%.. (press h for help or q to quit)"

