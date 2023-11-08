#syntax=docker/dockerfile:1.4

ARG UBUNTU_VERSION=18.04
ARG WINE_MONO_VERSION="7.4.0"
FROM ubuntu:${UBUNTU_VERSION}

ARG var_USERID=1000
ENV USERID=${var_USERID}

# Install some tools required for creating the image
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    wget \
	curl \
	unzip \
	ca-certificates

# enable 32-bit architecture support
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
    wine64 \
    wine32

# Use the latest version of winetricks
RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks \
	&& chmod +x /usr/local/bin/winetricks

# Get latest version of mono for wine
RUN mkdir -p /usr/share/wine/mono \
	&& curl -SL 'http://sourceforge.net/projects/wine/files/Wine%20Mono/${WINE_MONO_VERSION}/wine-mono-${WINE_MONO_VERSION}.msi/download' -o /usr/share/wine/mono/wine-mono-${WINE_MONO_VERSION}.msi \
	&& chmod +x /usr/share/wine/mono/wine-mono-${WINE_MONO_VERSION}.msi

# Let us be able to create a shared-wineprefix and /opt/ellisys.sh, later on
RUN mkdir -p /opt && chmod a+rwx /opt

# Wine really doesn't like to be run as root, so let's use a non-root user
RUN useradd -l --uid $USERID --create-home --shell /bin/bash wineuser
RUN cp /bin/chown          /tmp/chown_suid
RUN chmod a+rws            /tmp/chown_suid

# Drop out of root-shell
USER wineuser
WORKDIR /tmp
RUN mkdir -p /opt/wineprefix && chmod a+rwx /opt/wineprefix

# Use entry.sh as the entry point for 'docker run', rather than '/bin/sh -c'
ENTRYPOINT ["/assets/entry.sh"]
