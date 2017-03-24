#! /usr/bin/env bash

# Enable options:
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.
