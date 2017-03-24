#! /bin/sh

# Set node rights right
sanitize() { chmod -R u=rwX,g=rX,o= "$@" ; }

# Serve the directory locally
alias http-serve='python3 -m http.server'
