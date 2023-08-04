#!/bin/bash
# set -x; echo "entry.sh: $@"; env
export WINEARCH=win64
export WINEPREFIX=/opt/wineprefix

exec $@
