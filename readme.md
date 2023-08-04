# Purpose
As a Zephyr and Bluetooth developer, I sit exclusively in Linux.
Yet Ellisys GUI Protocol analyzer is Windows-only.
Avoid running Windows in a Virtual machine.


# Solution
Replace Microsoft Windows with open-source WINE.
Install WINE in a Docker container, for isolation and repeatabillity.
Install Microsoft .NET in WINE.
Install Ellisys in WINE.
Script these steps, resulting in wine_docker.sh


# Disclaimer
These scripts do not contain any IP and do not need to.
While Docker makes it easy to distribute images on DockerHub, doing so would violate copyright.


# Getting it
Build yourself:

    ./wine_docker.sh build_all

If the build breaks for some reason, different stages can be resumed.
Have patience -- it takes approx half an hour to complete all build steps (.NET install).


# Usage examples
Basically you call the script with a subcommand, e.g.:

    ./wine_docker.sh ellisys
    ./wine_docker.sh ellisys dump.btt
    ./wine_docker.sh ebq_viewer dump.thd
    ./wine_docker.sh interactive   # default behavior. Gives you a shell inside

# Troubleshooting

* Ellysis crashes when you try to open / save file </br>
    Change the docker user id in the docker image and recompile it.

* ebq_viewer crashes </br>
    Run it with a file first. After that the version without a file will work too.
    installing d3dx9 in addition to d3dcompiler_47 might fix it as well, but
    it's hard to reproduce this issue.
