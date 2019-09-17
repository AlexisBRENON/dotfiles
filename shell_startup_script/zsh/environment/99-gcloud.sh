#! /usr/bin/env zsh

gcloud_comp="/opt/google-cloud-sdk/completion.zsh.inc"

if command -vp gcloud > /dev/null; then
    if [ -e "$gcloud_comp" ]; then
        DEBUG "Loading gcloud completion"
        . "$gcloud_comp"
    else
        WARN "No gcloud completion found"
    fi
fi

