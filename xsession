sleep 3
pulseaudio --start -D # Audio deamon
urxvtd -q -f -o # Terminal server
xscreensaver -no-splash & # Screensaver back-end
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
wicd-gtk -t & # Network connection front-end (in tray -t)
syndaemon -t -k -i 2 & # Disable trackpad while typing
