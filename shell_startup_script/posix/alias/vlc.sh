#! /usr/bin/env sh

vlc_cast_to() {
    cvlc --audio-language "fr" --sout="#chromecast{ip=$1}" --sout-display "$2"
}

vlc_cast() {
    printf "Scanning for devices...\\n"
    IP="$(python3 - << EOS
import pychromecast; import sys
l = pychromecast.get_chromecasts()
ip = None
if len(l) == 0:
    print("No chromecast available.", file=sys.stderr)
elif len(l) == 1:
    print("One chromecast available: {} ({})".format(l[0].name, l[0].host), file=sys.stderr)
    ip = l[0].host
else:
    m = ["{} ({})".format(c=c) for c in l]
    print("\\n  ".join(m), file=sys.stderr)
    print("Where to cast", file=sys.stderr, end=' ')
    i = int(input())
    ip = l[i].host

if ip:
    print(ip)

EOS
)"
    if [ -n "$IP" ]; then
        vlc_cast_to "$IP" "$@"
    fi
}

vlc_spotify_record() {
    cvlc 'jack://channels=2:ports=output_.*' --sout='#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=file,mux=mp3,dst='$1'}'
}
