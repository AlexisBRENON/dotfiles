#! /usr/bin/env bash

export PROMPT_COMMAND="${PROMPT_COMMAND}; history -a; history -c; history -r"
