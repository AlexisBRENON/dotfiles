#! /usr/bin/env zsh

gcloud_comp="$(find /opt -path "*google-cloud*" -name "completion.zsh.inc" 2>/dev/null)"

if command -vp gcloud > /dev/null; then
    if [ -e "$gcloud_comp" ]; then
        DEBUG "Loading gcloud completion"
        . "$gcloud_comp"
    else
        WARN "No gcloud completion found"
    fi
fi

