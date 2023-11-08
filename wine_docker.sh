#!/bin/bash
IMAGE_STEP0="ubuntu_wine:18_04"                         # Layered
IMAGE_STEP1="ubuntu_wine_dotnet48:18_04"                # Layered
IMAGE_STEP2="ubuntu_wine_dotnet48_tricks:18_04"         # Layered
IMAGE_STEP3="ubuntu_wine_dotnet48_tricks_ellisys:18_04" # Layered
IMAGE_STEP4="ellisys:18_04"                             # Squashed

export ELLISYS_WINE_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

function sudo_docker_run
{
    export CONTAINER_ID_FILE="/dev/shm/container_id.$(date +%s)"

    # Just be a normal interactive shell
    local opts_default="--interactive=true --tty=true --privileged"

    # If '--rm' is omitted, we may use this to commit the container
    local save_container_id="--cidfile=${CONTAINER_ID_FILE}"

    local pass_through_files="-v ${ELLISYS_WINE_DIR}/assets:/assets:rw -v /:/mnt/host_root:rw -v /dev/bus/usb:/dev/bus/usb"
    mkdir -p "${ELLISYS_WINE_DIR}/assets/tmp" && chmod a+rwx "${ELLISYS_WINE_DIR}/assets/tmp"  # Let container write
    mkdir -p "${ELLISYS_WINE_DIR}/settings" && chmod a+rwx "${ELLISYS_WINE_DIR}/settings"  # Let container write
    mkdir -p "${ELLISYS_WINE_DIR}/saves" && chmod a+rwx "${ELLISYS_WINE_DIR}/saves"  # Let container write

    local pass_through_network="--net=host"

    # '--ipc host' prevents crashes of the kind:
    #         X Error of failed request:  BadValue (integer parameter out of range for operation)
    #           Major opcode of failed request:  130 (MIT-SHM)
    #           Minor opcode of failed request:  3 (X_ShmPutImage)
    #           Value in failed request:  0x3c0
    #           Serial number of failed request:  700542
    #           Current serial number in output stream:  700543
    # See also https://stackoverflow.com/questions/38907708/docker-ipc-host-and-security
    local pass_through_graphics="-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v ${HOME}/.Xauthority:/root/.Xauthority:rw --device /dev/dri:/dev/dri --ipc host"

    # TODO: Test audio
    local pass_through_audio="--device /dev/snd:/dev/snd"

    xhost +local:docker  # Let docker daemon display in our X session
    (
        umask o+r  # Let anybody read $CONTAINER_ID_FILE
        sudo docker run \
            ${opts_default} \
            ${save_container_id} \
            ${pass_through_files} \
            ${pass_through_network} \
            ${pass_through_graphics} \
            ${pass_through_audio} \
            $@
    )
}

# A docker image may consist of many layers.
# Removing files from one layer will just map them out; size remains unchanged until flattened.
function sudo_docker_squash {
    local image_input="${1}"
    local image_output="${2:-${image_input}.squashed}"

# Avoid experimental --squash flag (requires modification of daemon settings)
{
cat << EOF
FROM ${image_input} AS src

# 'FROM' starts a new layer; here we create a flat layer. 'scratch' is the empty image
FROM scratch AS dst

# Copy everything from above into the empty image
COPY --from=src / /
EOF
} | sudo docker build -t "${image_output}" --build-arg var_USERID=$(id --user) -

}

function determine_ellisys_version {
    local downloaded_msi="$1"
    strings "$downloaded_msi" \
    | grep --color=never -Eo '([0-9\.])+ProductVersion' \
    | grep --color=never -Eo '([0-9\.])+'
}

function auto_version {
    local safe_date=$(date "+%Y-%m-%d_%H.%M.%S")
    local ev="$(determine_ellisys_version assets/tmp/bta.msi)"
    local ev_safe="${ev:-${safe_date}}"
    echo "${ev_safe}"
}


# Install wine on Ubuntu
# Approx 1.72 GB
function build_step0 {
    cat Dockerfile | sudo docker build -t "${IMAGE_STEP0}" --build-arg var_USERID=$(id --user) -
}

# Fetch+Install Microsoft .NET, automatically
# Approx 2.87 GB
function build_step1 {
    sudo_docker_run "${IMAGE_STEP0}" /assets/install_dotnet.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP1}"
}

# Add necessary tricks
function build_step2 {
    sudo_docker_run "${IMAGE_STEP1}" /assets/install_tricks.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP2}"
}

# # Fetch+Install Ellisys, automatically
# # Approx 3.22 GB
# function build_step3 {
#     sudo_docker_run "${IMAGE_STEP2}" /assets/install_ellisys.sh
#     sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP3}"
#     sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP3}-$(auto_version)"
# }

# Fetch+Install Ellisys, automatically
# Approx 3.22 GB
function build_step3 {
    sudo_docker_run "${IMAGE_STEP2}" /assets/install_ellisys_qualifier.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP3}"
    # sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP3}-$(auto_version)"
}

# Optional. Slim down: Remove unnecessary wine-dependencies, collapse duplicate files installed by .NET
# Approx 1.08 GB (FROM debian:testing)
# Approx 2.17 GB (FROM debian:bullseye). TODO: Reduce further
function build_step4 {
    sudo_docker_run "${IMAGE_STEP3}" /assets/minimize.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP4}.layered"
    sudo_docker_squash "${IMAGE_STEP4}.layered" "${IMAGE_STEP4}-$(auto_version)"
}

function build_all {
    build_step0
    build_step1
    build_step2
    build_step3
    # build_step4
}

function interactive {
    local myself="$(id --user):$(id --group)"
    sudo_docker_run -u "$myself" -v ${ELLISYS_WINE_DIR}/settings/:/opt/wineprefix/drive_c/users/wine/AppData/Roaming/Ellisys/:rw --rm "${IMAGE_STEP3}" bash
}

function ellisys {
    local file_unix=${1:+$(realpath "$1")}  # optional. File to load
    local file_dos="${file_unix:+H:}${file_unix}"  # no need to flip slashes for wine
    shift

    {
        local myself="$(id --user):$(id --group)"
        sudo_docker_run -u "$myself" -p "8080:8080" -v ${ELLISYS_WINE_DIR}/settings/:/opt/wineprefix/drive_c/users/wine/AppData/Roaming/Ellisys/:rw \
            -v ${ELLISYS_WINE_DIR}/saves:/opt/wineprefix/drive_c/users/wine/Documents -e WINEDEBUG=fixme-all --rm "${IMAGE_STEP3}" /opt/ellisys.sh "${file_dos}" $@
    }
}

function ebq_viewer {
    local file_unix=${1:+$(realpath "$1")}  # optional. File to load
    local file_dos="${file_unix:+H:}${file_unix}"  # no need to flip slashes for wine
    shift

    {
        local myself="$(id --user):$(id --group)"
        sudo_docker_run -u "$myself" -e WINEDEBUG=fixme-all --rm "${IMAGE_STEP3}" /opt/ebq_viewer.sh "${file_dos}" $@
    }
}

function ebq_qualifier {
    local file_unix=${1:+$(realpath "$1")}  # optional. File to load
    local file_dos="${file_unix:+H:}${file_unix}"  # no need to flip slashes for wine
    shift

    {
        local myself="$(id --user):$(id --group)"
        sudo_docker_run -u "$myself" -e WINEDEBUG=fixme-all --rm "${IMAGE_STEP3}" /opt/ebq_qualifier.sh "${file_dos}" $@
    }
}


${@:-interactive}
