#!/bin/bash

# See https://appdb.winehq.org/objectManager.php?sClass=version&iId=34219
WINEDLLOVERRIDES="mscoree,mshtml=" wineboot --init
winetricks --unattended --force tahoma gdiplus

#the EBQ viewer requires DirectX
winetricks --unattended --force d3dcompiler_47

chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff

rm -rf /tmp/*wine*
