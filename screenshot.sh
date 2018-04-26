#!/bin/sh

DATE="$(date +%Y%M%d-%H%M%S)-$(date +%N | cut -c1-3)"
FILENAME="screenshot-$DATE.png"

import "$@" "$HOME/$FILENAME" 2> "$HOME/.screenshotError"

notify-send "Impression d'écran" "$FILENAME enregistré"
