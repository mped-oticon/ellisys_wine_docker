#!/bin/bash

# See https://appdb.winehq.org/objectManager.php?sClass=version&iId=34219
WINEDLLOVERRIDES="mscoree,mshtml=" wineboot --init
winetricks --unattended --force dotnet48 corefonts
chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff

rm -rf /tmp/*wine*
