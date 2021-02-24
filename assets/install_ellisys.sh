#!/bin/bash

MSI_PATH="/assets/tmp/bta.msi"    # Store outside docker-image
INSTALL_FOLDER="C:\Ellisys"

test -e "${MSI_PATH}" || {
    echo "### Could not find Ellisys installer. Downloading..."
    wget -O "${MSI_PATH}" "https://www.ellisys.com/better_analysis/bta_get.php"
#   wget -O "${MSI_PATH}" "https://www.ellisys.com/better_analysis/bta_get.php?v=5.0.7690.40428"
}

test -e "${MSI_PATH}" || {
    echo "### Could not find Ellisys installer at '${MSI_PATH}'. Giving up."
    exit 1
}

# Install Ellisys
# msiexec args documentation: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec
# Properties can also be specified in a key=value fashion
# Install dir is a property, but many different conventions exists -- try them all
echo "### Installing Ellisys at '${INSTALL_FOLDER}'..."
wine msiexec \
    /i "${MSI_PATH}" \
    /passive \
    TARGETDIR="${INSTALL_FOLDER}" \
    INSTALLDIR="${INSTALL_FOLDER}" \
    INSTALLFOLDER="${INSTALL_FOLDER}" \
    INSTALLPATH="${INSTALL_FOLDER}" \
    INSTALLLOCATION="${INSTALL_FOLDER}" \
    APPLICATIONFOLDER="${INSTALL_FOLDER}" \
    APPDIR="${INSTALL_FOLDER}" \
&& echo "### Installed Ellisys at '${INSTALL_FOLDER}'."
chmod -R a+rxw "$WINEPREFIX"  # Ensure everybody can access newly installed stuff

{
cat << EOF
#!/bin/bash

# wineuser owns $WINEPREFIX folder, so only {root,wineuser} can change ownership to our user
myself="\$(id --user):\$(id --group)"
/tmp/chown_suid "\$myself" "\$WINEPREFIX"                         # make wine happy
/tmp/chown_suid "\$myself" /tmp/chown_suid && rm /tmp/chown_suid  # clean-up

ln -s /mnt/host_root "\${WINEPREFIX}/dosdevices/h:"

wine "${INSTALL_FOLDER}\Ellisys.BluetoothAnalyzer.exe" \$@
EOF
} > "/opt/ellisys.sh"
chmod +x "/opt/ellisys.sh"
