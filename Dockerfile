FROM debian:bullseye

# Install wine
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y cabextract gnupg2
RUN apt-get install -y wget software-properties-common
RUN wget -q -O - http://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository http://dl.winehq.org/wine-builds/debian/
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-stable

# Install winetricks
RUN wget --no-check-certificate -q -O /usr/local/bin/winetricks 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks'
RUN chmod +x /usr/local/bin/winetricks

# Let us be able to create a shared-wineprefix and /opt/ellisys.sh, later on
RUN mkdir -p /opt && chmod a+rwx /opt

#####

# Don't trust Windows software wih root-creds: Create an unprivileged user to run WINE stuff
RUN useradd --uid 65000 --create-home --shell /bin/bash wineuser

# WINE will complain if the user doesn't own /opt/wineprefix.
# Currently 'wineuser' is the owner, but we propagate user-id through Docker.
# So we don't know upfront who the user is, but WINE can be appeased by chowning the prefix root folder only.
# This ownership change is done once by entry.sh upon every docker-run.
# But in Linux, only {root, owner} may change ownership.
# 'myself' can't change ownership of /opt/wineprefix, without being wineuser or root.
# So we make an escape-hatch, that entry.sh removes after use.
RUN cp /bin/chown          /tmp/chown_suid
RUN chmod a+rws            /tmp/chown_suid

# Drop out of root-shell
USER wineuser
WORKDIR /tmp
RUN mkdir -p /opt/wineprefix && chmod a+rwx /opt/wineprefix

# Tell docker to use this as entrypoint for 'docker run', rather than "/bin/sh -c"
ENTRYPOINT ["/assets/entry.sh"]
