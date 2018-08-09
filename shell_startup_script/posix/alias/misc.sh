#! /bin/sh

# Set node rights right
sanitize() { chmod -R u=rwX,g=rX,o= "$@" ; }

