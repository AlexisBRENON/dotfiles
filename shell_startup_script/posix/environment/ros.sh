#! /bin/sh

if [[ -d /opt/ros ]]; then
  # Get last ROS install
  export ROS_DISTRO="$(ls -1 -t /opt/ros | head -n 1)"
  export ROS_ROOT="/opt/ros/$ROS_DISTRO"
  export ROS_HOME="$HOME/.cache/ros/$ROS_DISTRO"

  . "$ROS_ROOT/setup.sh"

  export ROS_MASTER_URI="http://$(hostname -I | cut -d" " -f1):11311"
fi

