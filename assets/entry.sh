#!/bin/bash
# set -x; echo "entry.sh: $@"; env
export WINEARCH=win32
export WINEPREFIX=/opt/wineprefix

exec $@
