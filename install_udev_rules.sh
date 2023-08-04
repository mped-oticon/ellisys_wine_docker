#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Must be run as root"
  exit
fi

cp 99-ellisys.rules /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger
