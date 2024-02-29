#!/bin/bash

WINEDLLOVERRIDES="mscoree,mshtml=" wineboot --init
winetricks --unattended --force dotnet472
wine uninstaller --list
chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff

rm -rf /tmp/*wine*
