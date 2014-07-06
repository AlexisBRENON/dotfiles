sleep 3
pulseaudio --start -D
urxvtd -q -f -o
xscreensaver -no-splash &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
nm-applet &