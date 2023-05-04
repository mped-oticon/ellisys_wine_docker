#!/bin/bash
IMAGE_STEP0="debian_wine:bullseye"                   # Layered
IMAGE_STEP1="debian_wine_dotnet461:bullseye"         # Layered
IMAGE_STEP2="debian_wine_dotnet461_ellisys:bullseye" # Layered
IMAGE_STEP3="ellisys:bullseye"                       # Squashed

export ELLISYS_WINE_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

function sudo_docker_run
{
    export CONTAINER_ID_FILE="/dev/shm/container_id.$(date +%s)"

    # Just be a normal interactive shell
    local opts_default="--interactive=true --tty=true"

    # If '--rm' is omitted, we may use this to commit the container
    local save_container_id="--cidfile=${CONTAINER_ID_FILE}"

    local pass_through_files="-v ${ELLISYS_WINE_DIR}/assets:/assets:rw -v /:/mnt/host_root:rw"
    mkdir -p "${ELLISYS_WINE_DIR}/assets/tmp" && chmod a+rwx "${ELLISYS_WINE_DIR}/assets/tmp"  # Let container write

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
} | sudo docker build -t "${image_output}" -

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


# Install wine into debian
# Approx 1.72 GB
function build_step0 {
    cat Dockerfile | sudo docker build -t "${IMAGE_STEP0}" -
}

# Fetch+Install Microsoft .NET, automatically
# Approx 2.87 GB
function build_step1 {
    sudo_docker_run "${IMAGE_STEP0}" /assets/install_dotnet.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP1}"
}

# Fetch+Install Ellisys, automatically
# Approx 3.22 GB
function build_step2 {
    sudo_docker_run "${IMAGE_STEP1}" /assets/install_ellisys.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP2}"
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP2}-$(auto_version)"
}

# Optional. Slim down: Remove unessecary wine-dependencies, collapse duplicate files installed by .NET
# Approx 1.08 GB (FROM debian:testing)
# Approx 2.17 GB (FROM debian:bullseye). TODO: Reduce further
function build_step3 {
    sudo_docker_run "${IMAGE_STEP2}" /assets/minimize.sh
    sudo docker commit $(cat "${CONTAINER_ID_FILE}") "${IMAGE_STEP3}.layered"
    sudo_docker_squash "${IMAGE_STEP3}.layered" "${IMAGE_STEP3}-$(auto_version)"
}

function build_all {
    build_step0
    build_step1
    build_step2
    # build_step3
}

function interactive {
    local myself="$(id --user):$(id --group)"
    sudo_docker_run -u "$myself" --rm "${IMAGE_STEP2}" bash
}

function ellisys {
    local file_unix="$1"  # optional. File to load
    local file_dos="${file_unix:+H:}${file_unix}"  # no need to flip slashes for wine
    shift

    {
        local myself="$(id --user):$(id --group)"
        sudo_docker_run -u "$myself" --rm "${IMAGE_STEP2}" /opt/ellisys.sh "${file_dos}" $@
    } | grep -v ":fixme:"  # reduce verbosity of wine-warnings
}

${@:-interactive}
