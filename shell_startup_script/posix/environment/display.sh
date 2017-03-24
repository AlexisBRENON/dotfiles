#! /bin/sh

#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#--------------------------------------------------------------

get_xserver ()
{
  case $TERM in
    xterm )
      XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
      # Ane-Pieter Wieringa suggests the following alternative:
      #  I_AM=$(who am i)
      #  SERVER=${I_AM#*(}
      #  SERVER=${SERVER%*)}
      XSERVER=${XSERVER%%:*}
      ;;
    aterm | rxvt)
      # Find some code that works here. ...
      ;;
  esac
}

if [ -z "${DISPLAY}" ]; then
  get_xserver
  case ${XSERVER} in
    (""|"${HOST}"|"unix")
      DISPLAY=":0.0"          # Display on local host.
      ;;
    (*)
      DISPLAY=${XSERVER}:0.0     # Display on remote host.
      ;;
  esac
fi

export DISPLAY
unset get_xserver
