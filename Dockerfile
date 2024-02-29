#syntax=docker/dockerfile:1.4

ARG UBUNTU_VERSION=18.04
FROM ubuntu:${UBUNTU_VERSION} as ubuntu-base

ARG var_USERID=1000
ENV USERID {var_USERID}

####################################

# https://github.com/suchja/x11client/blob/master/Dockerfile

RUN addgroup --system wineuser \
    && adduser \
	--home /home/wineuser \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running an xclient application" \
	--ingroup wineuser \
	--quiet \
	wineuser

# Install packages required for connecting against X Server
# Xvfb provides a window server that emulates both the display and input devices.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends xvfb xauth

# ================================ WINE =================================
# https://github.com/suchja/wine/blob/master/Dockerfile
FROM ubuntu-base as wine-base

ENV WINE_MONO_VERSION 4.7.3

# Install some tools required for creating the image
RUN apt-get update && apt-get install -y --no-install-recommends \
	curl \
	unzip \
	ca-certificates

# WINE
RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends wine32

# WINETRICKS
RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks \
		&& chmod +x /usr/local/bin/winetricks

# WINE MONO
RUN mkdir -p /usr/share/wine/mono \
	&& curl -SL 'http://sourceforge.net/projects/wine/files/Wine%20Mono/$WINE_MONO_VERSION/wine-mono-$WINE_MONO_VERSION.msi/download' -o /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi \
	&& chmod +x /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi

# Wine really doesn't like to be run as root, so let's use a non-root user
USER wineuser
ENV HOME /home/wineuser
ENV WINEPREFIX /home/wineuser/.wine
ENV WINEARCH win32
ENV WINEDEBUG=fixme-all

WORKDIR /home/wineuser
# RUN echo "alias winegui='wine explorer /desktop=DockerDesktop,1024x768'" > ~/.bash_aliases

# ================================ EBQ Qualifier =================================
FROM wine-base as EBQ

ARG EBQ_EXE=EllisysBluetoothQualifierInstaller-2023-1.8710.exe
ARG EBQ_PATH=/assets/tmp/${EBQ_EXE}
ARG EBQ_INSTALL_FOLDER="C:\Ellisys"

ADD ${EBQ_PATH} .

ENTRYPOINT [ "wine", "${EBQ_EXE}.exe"]
