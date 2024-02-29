#!/bin/bash

BTA_PATH="/assets/tmp/bta.msi"    # Store outside docker-image
BTA_URL="https://www.ellisys.com/better_analysis/bta_get.php"
#BTA_URL="https://www.ellisys.com/better_analysis/bta_get.php?v=5.0.8393.22590"
EBQ_VIEWER_PATH="/assets/tmp/EBQ_viewer.exe"    # Store outside docker-image
INSTALL_FOLDER="C:\Ellisys"
BTA_INSTALL_FOLDER="${INSTALL_FOLDER}\Ellisys Bluetooth Analyzer"
EBQ_VIEWER_INSTALL_FOLDER="${INSTALL_FOLDER}\Ellisys Bluetooth Qualifier Viewer"

BTA_SIZE=$(wc -c $BTA_PATH)
BTA_DL_SIZE=$(wget $BTA_URL --spider --server-response -O - 2>&1 | sed -ne '/Content-Length/{s/.*: //;p}')
if ( test -e "${BTA_PATH}" && [ "${BTA_SIZE%% *}" = "$BTA_DL_SIZE" ])
then
    echo "### Already have the latest installer, skipping download"
else
    echo "### Could not find Ellisys installer. Downloading..."
    wget -O "${BTA_PATH}" "${BTA_URL}"
fi

test -e "${BTA_PATH}" || {
    echo "### Could not find Ellisys installer at '${BTA_PATH}'. Giving up."
    exit 1
}

# Install Ellisys
# msiexec args documentation: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec
# Properties can also be specified in a key=value fashion
# Install dir is a property, but many different conventions exists -- try them all
echo "### Installing Ellisys Bluetooth Analyzer at '${BTA_INSTALL_FOLDER}'..."
wine64 msiexec \
    /i "${BTA_PATH}" \
    /passive \
    TARGETDIR="${BTA_INSTALL_FOLDER}" \
    INSTALLDIR="${BTA_INSTALL_FOLDER}" \
    INSTALLFOLDER="${BTA_INSTALL_FOLDER}" \
    INSTALLPATH="${BTA_INSTALL_FOLDER}" \
    INSTALLLOCATION="${BTA_INSTALL_FOLDER}" \
    APPLICATIONFOLDER="${BTA_INSTALL_FOLDER}" \
    APPDIR="${BTA_INSTALL_FOLDER}" \
&& echo "### Installed Ellisys at '${BTA_INSTALL_FOLDER}'."

{
cat << EOF
#!/bin/bash

# wineuser owns $WINEPREFIX folder, so only {root,wineuser} can change ownership to our user
myself="\$(id --user):\$(id --group)"
/tmp/chown_suid "\$myself" "\$WINEPREFIX"                         # make wine happy
/tmp/chown_suid "\$myself" /tmp/chown_suid && rm /tmp/chown_suid  # clean-up

ln -s /mnt/host_root "\${WINEPREFIX}/dosdevices/h:"

wine64 "${BTA_INSTALL_FOLDER}\Ellisys.BluetoothAnalyzer.exe" \$@
EOF
} > "/opt/ellisys.sh"
chmod +x "/opt/ellisys.sh"


test -e "${EBQ_VIEWER_PATH}" || {
    echo "### Could not find Ellisys installer. Downloading..."
    wget -O "${EBQ_VIEWER_PATH}.zip" "https://www.ellisys.com/better_analysis/ebq_viewer_8424.zip"
    unzip "${EBQ_VIEWER_PATH}.zip"
    mv EllisysBluetoothQualifierViewerInstaller* "${EBQ_VIEWER_PATH}"
    rm "${EBQ_VIEWER_PATH}.zip"
}

test -e "${EBQ_VIEWER_PATH}" || {
    echo "### Could not find Ellisys installer at '${EBQ_VIEWER_PATH}'. Giving up."
    exit 1
}

echo "### Installing Ellisys Bluetooth Qualifier Viewer at '${EBQ_VIEWER_INSTALL_FOLDER}'..."
wine64 ${EBQ_VIEWER_PATH} /VERYSILENT /DIR="${EBQ_VIEWER_INSTALL_FOLDER}"

{
cat << EOF
#!/bin/bash

# wineuser owns $WINEPREFIX folder, so only {root,wineuser} can change ownership to our user
myself="\$(id --user):\$(id --group)"
/tmp/chown_suid "\$myself" "\$WINEPREFIX"                         # make wine happy
/tmp/chown_suid "\$myself" /tmp/chown_suid && rm /tmp/chown_suid  # clean-up

ln -s /mnt/host_root "\${WINEPREFIX}/dosdevices/h:"

wine64 "${EBQ_VIEWER_INSTALL_FOLDER}\Ellisys.BQ1.TesterViewer.exe" \$@
EOF
} > "/opt/ebq_viewer.sh"
chmod +x "/opt/ebq_viewer.sh"

chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff
