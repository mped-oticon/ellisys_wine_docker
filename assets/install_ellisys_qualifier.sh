#!/bin/bash

EBQ_URL="https://www.ellisys.com/better_analysis/ebq/ebq_8710.zip" # 2023-11-06
EBQ_PATH="/assets/tmp/EllisysBluetoothQualifierInstaller-2023-1.8710.exe"
EBQ_INSTALL_FOLDER="C:\Ellisys\Ellisys Bluetooth Qualifier Viewer"

test -e "${EBQ_PATH}" || {
    echo "### Could not find Ellisys Qualifier installer. Downloading..."
    wget -O "${EBQ_PATH}.zip" "${EBQ_URL}"
    unzip "${EBQ_PATH}.zip"
    mv EllisysBluetoothQualifierInstaller* "${EBQ_PATH}"
    rm "${EBQ_PATH}.zip"
}

test -e "${EBQ_PATH}" || {
    echo "### Could not find Ellisys installer at '${EBQ_PATH}'. Giving up."
    exit 1
}

echo "### Installing Ellisys Bluetooth Qualifier at '${EBQ_INSTALL_FOLDER}'..."
wine ${EBQ_PATH} /VERYSILENT /DIR=${EBQ_INSTALL_FOLDER}

{
cat << EOF
#!/bin/bash

# wineuser owns $WINEPREFIX folder, so only {root,wineuser} can change ownership to our user
myself="\$(id --user):\$(id --group)"
/tmp/chown_suid "\$myself" "\$WINEPREFIX"                         # make wine happy
/tmp/chown_suid "\$myself" /tmp/chown_suid && rm /tmp/chown_suid  # clean-up

ln -s /mnt/host_root "\${WINEPREFIX}/dosdevices/h:"

ls ${EBQ_INSTALL_FOLDER}

wine ${EBQ_INSTALL_FOLDER}\Ellisys.BQ1.TesterViewer.exe \$@
EOF
} > "/opt/ebq_qualifier.sh"
chmod +x "/opt/ebq_qualifier.sh"

chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff
