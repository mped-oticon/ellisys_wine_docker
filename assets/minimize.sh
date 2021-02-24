#!/bin/bash

# Remove setup files and cache
rm -rf /root/.cache
rm -rf /root/.wine/drive_c/users/root/Temp
rm -rf /root/.wine/drive_c/windows/Installer
rm -rf /root/.wine/drive_c/windows/Microsoft.NET/Framework/*/SetupCache

# Unused 64-bit DLLs. Determined via find /usr -atime +1 -type f -exec ls -lu {} \;
rm -rf /usr/lib/x86_64-linux-gnu/wine/fakedlls
rm -rf /usr/lib/x86_64-linux-gnu/wine/d3dx9*.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/actxprxy.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/cmd.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/comctl32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/comdlg32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/crtdll.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/crypt32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/cryptui.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/dwrite.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/gdi32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/jscript.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/kernel32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/kernelbase.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/libwine.so.1.0
rm -rf /usr/lib/x86_64-linux-gnu/wine/mshtml.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/mshtml.tlb.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msi.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp100.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp110.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp120.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp140.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp60.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp70.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp71.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp80.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp90.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr100.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr110.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr120.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr70.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr71.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr80.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr90.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcrtd.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcrt.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msxml3.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ntdll.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ole32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/oleaut32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/opengl32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/quartz.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/regedit.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/shell32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/taskmgr.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ucrtbase.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/urlmon.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/user32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/windowscodecs.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winecfg.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/wined3d.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/wineps.drv.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winex11.drv.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/wininet.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winmm.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/urlmon.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/dwrite.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/wininet.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/jscript.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winmm.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winex11.drv.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/wineps.drv.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/taskmgr.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/winecfg.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/crtdll.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/kernelbase.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcrtd.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr70.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr71.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/regedit.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/quartz.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcrt.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/cmd.exe.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr90.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr80.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/cryptui.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/crypt32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp100.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp120.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp140.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp110.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr100.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/mshtml.tlb.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/windowscodecs.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/oleaut32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr110.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp60.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcr120.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/gdi32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/comdlg32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp70.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ucrtbase.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msxml3.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp71.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp80.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msvcp90.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/actxprxy.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/msi.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ole32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/comctl32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/libwine.so.1.0
rm -rf /usr/lib/x86_64-linux-gnu/wine/wined3d.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/opengl32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/mshtml.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/user32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/kernel32.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/ntdll.dll.so
rm -rf /usr/lib/x86_64-linux-gnu/wine/shell32.dll.so

# Collapse duplicate files. Many MS.NET files are duplicated
apt-get install -y rdfind
rdfind -makesymlinks true /root/.wine /usr

# Towards distro-less wine: Remove uneeded packages
dpkg --purge --force-all rdfind udev systemd systemd-timesyncd

dpkg --purge --force-all \
                         bind9-libs:amd64 \
                         libaa1:amd64 \
                         libaa1:i386 \
                         libacl1:amd64 \
                         libaom0:amd64 \
                         libaom0:i386 \
                         libapparmor1:amd64 \
                         libapt-pkg6.0:amd64 \
                         libargon2-1:amd64 \
                         libasound2:amd64 \
                         libasound2-data:amd64 \
                         libasound2-data:i386 \
                         libasyncns0:amd64 \
                         libatomic1:i386 \
                         libattr1:amd64 \
                         libaudit1:amd64 \
                         libavahi-client3:amd64 \
                         libavahi-client3:i386 \
                         libavahi-common3:amd64 \
                         libavahi-common3:i386 \
                         libavahi-core7:amd64 \
                         libavc1394-0:amd64 \
                         libavc1394-0:i386 \
                         libavcodec58:amd64 \
                         libavcodec58:i386 \
                         libavresample4:amd64 \
                         libavresample4:i386 \
                         libavutil56:amd64 \
                         libavutil56:i386 \
                         libblkid1:amd64 \
                         libblkid1:i386 \
                         libbpf0:amd64 \
                         libbsd0:amd64 \
                         libbz2-1.0:amd64 \
                         libbz2-1.0:i386 \
                         libcaca0:amd64 \
                         libcaca0:i386 \
                         libcairo2:amd64 \
                         libcairo2:i386 \
                         libcairo-gobject2:amd64 \
                         libcairo-gobject2:i386 \
                         libcap2:amd64 \
                         libcap2:i386 \
                         libcapi20-3:amd64 \
                         libcapi20-3:i386 \
                         libcap-ng0:amd64 \
                         libcdparanoia0:amd64 \
                         libcdparanoia0:i386 \
                         libcodec2-0.9:amd64 \
                         libcodec2-0.9:i386 \
                         libcom-err2:amd64 \
                         libcryptsetup12:amd64 \
                         libcups2:amd64 \
                         libcups2:i386 \
                         libcurl3-gnutls:amd64 \
                         libcurl3-gnutls:i386 \
                         libcurl4:amd64 \
                         libcurl4:i386 \
                         libdaemon0:amd64 \
                         libdatrie1:amd64 \
                         libdatrie1:i386 \
                         libdav1d4:amd64 \
                         libdav1d4:i386 \
                         libdb5.3:amd64 \
                         libdb5.3:i386 \
                         libdbus-1-3:amd64 \
                         libdconf1:amd64 \
                         libdebconfclient0:amd64 \
                         libdeflate0:amd64 \
                         libdeflate0:i386 \
                         libdevmapper1.02.1:amd64 \
                         libdrm2:amd64 \
                         libdrm-amdgpu1:amd64 \
                         libdrm-amdgpu1:i386 \
                         libdrm-intel1:amd64 \
                         libdrm-intel1:i386 \
                         libdrm-nouveau2:amd64 \
                         libdrm-nouveau2:i386 \
                         libdrm-radeon1:amd64 \
                         libdrm-radeon1:i386 \
                         libdv4:amd64 \
                         libdv4:i386 \
                         libdw1:amd64 \
                         libdw1:i386 \
                         libedit2:amd64 \
                         libedit2:i386 \
                         libelf1:amd64 \
                         libelf1:i386 \
                         libexif12:amd64 \
                         libexif12:i386 \
                         libext2fs2:amd64 \
                         libfaudio0:amd64 \
                         libfaudio0:i386 \
                         libffi7:amd64 \
                         libflac8:amd64 \
                         libfribidi0:amd64 \
                         libfribidi0:i386 \
                         libfstrm0:amd64 \
                         libgbm1:amd64 \
                         libgcc-s1:amd64 \
                         libgcrypt20:amd64 \
                         libgd3:amd64 \
                         libgd3:i386 \
                         libgdbm6:amd64 \
                         libgdbm6:i386 \
                         libgdbm-compat4:amd64 \
                         libgdbm-compat4:i386 \
                         libgdk-pixbuf-2.0-0:amd64 \
                         libgdk-pixbuf-2.0-0:i386 \
                         libgl1:amd64 \
                         libgl1:i386 \
                         libgl1-mesa-dri:amd64 \
                         libgl1-mesa-dri:i386 \
                         libglapi-mesa:amd64 \
                         libglapi-mesa:i386 \
                         libglib2.0-0:amd64 \
                         libglib2.0-0:i386 \
                         libglu1-mesa:amd64 \
                         libglu1-mesa:i386 \
                         libglvnd0:amd64 \
                         libglvnd0:i386 \
                         libglx0:amd64 \
                         libglx0:i386 \
                         libglx-mesa0:amd64 \
                         libglx-mesa0:i386 \
                         libgmp10:amd64 \
                         libgomp1:amd64 \
                         libgomp1:i386 \
                         libgpg-error0:amd64 \
                         libgphoto2-6:amd64 \
                         libgphoto2-6:i386 \
                         libgphoto2-port12:amd64 \
                         libgphoto2-port12:i386 \
                         libgpm2:amd64 \
                         libgpm2:i386 \
                         libgraphite2-3:amd64 \
                         libgraphite2-3:i386 \
                         libgsm1:amd64 \
                         libgsm1:i386 \
                         libgssapi-krb5-2:amd64 \
                         libgstreamer1.0-0:amd64 \
                         libgstreamer1.0-0:i386 \
                         libgstreamer-plugins-base1.0-0:amd64 \
                         libgstreamer-plugins-base1.0-0:i386 \
                         libgudev-1.0-0:amd64 \
                         libgudev-1.0-0:i386 \
                         libharfbuzz0b:amd64 \
                         libharfbuzz0b:i386 \
                         libhogweed6:amd64 \
                         libicu67:amd64 \
                         libicu67:i386 \
                         libidn2-0:amd64 \
                         libiec61883-0:amd64 \
                         libiec61883-0:i386 \
                         libieee1284-3:amd64 \
                         libieee1284-3:i386 \
                         libigdgmm11:amd64 \
                         libigdgmm11:i386 \
                         libip4tc2:amd64 \
                         libjack-jackd2-0:amd64 \
                         libjack-jackd2-0:i386 \
                         libjbig0:amd64 \
                         libjbig0:i386 \
                         libjpeg62-turbo:amd64 \
                         libjpeg62-turbo:i386 \
                         libjson-c5:amd64 \
                         libk5crypto3:amd64 \
                         libkeyutils1:amd64 \
                         libkmod2:amd64 \
                         libkrb5-3:amd64 \
                         libkrb5support0:amd64 \
                         liblcms2-2:amd64 \
                         liblcms2-2:i386 \
                         libldap-2.4-2:amd64 \
                         libldap-2.4-2:i386 \
                         libllvm11:amd64 \
                         libllvm11:i386 \
                         liblmdb0:amd64 \
                         libltdl7:amd64 \
                         libltdl7:i386 \
                         liblz4-1:amd64 \
                         liblzma5:amd64 \
                         libmaxminddb0:amd64 \
                         libmfx1:amd64 \
                         libmfx1:i386 \
                         libmnl0:amd64 \
                         libmount1:amd64 \
                         libmount1:i386 \
                         libmp3lame0:amd64 \
                         libmp3lame0:i386 \
                         libmpg123-0:amd64 \
                         libmpg123-0:i386 \
                         libmspack0:amd64 \
                         libnettle8:amd64 \
                         libnghttp2-14:amd64 \
                         libnghttp2-14:i386 \
                         libnsl2:amd64 \
                         libnspr4:amd64 \
                         libnspr4:i386 \
                         libnss3:amd64 \
                         libnss3:i386 \
                         libnss-mdns:amd64 \
                         libnss-nis:i386 \
                         libnss-nisplus:i386 \
                         libnss-systemd:amd64 \
                         libnuma1:amd64 \
                         libnuma1:i386 \
                         libodbc1:amd64 \
                         libodbc1:i386 \
                         libogg0:amd64 \
                         libopenal1:amd64 \
                         libopenal1:i386 \
                         libopenjp2-7:amd64 \
                         libopenjp2-7:i386 \
                         libopus0:amd64 \
                         liborc-0.4-0:amd64 \
                         liborc-0.4-0:i386 \
                         libosmesa6:amd64 \
                         libosmesa6:i386 \
                         libp11-kit0:amd64 \
                         libpam0g:amd64 \
                         libpango-1.0-0:amd64 \
                         libpango-1.0-0:i386 \
                         libpangocairo-1.0-0:amd64 \
                         libpangocairo-1.0-0:i386 \
                         libpangoft2-1.0-0:amd64 \
                         libpangoft2-1.0-0:i386 \
                         libpcap0.8:amd64 \
                         libpcap0.8:i386 \
                         libpci3:amd64 \
                         libpci3:i386 \
                         libpciaccess0:amd64 \
                         libpciaccess0:i386 \
                         libperl5.32:amd64 \
                         libperl5.32:i386 \
                         libpixman-1-0:amd64 \
                         libpixman-1-0:i386 \
                         libpoppler102:amd64 \
                         libpoppler102:i386 \
                         libpoppler-glib8:amd64 \
                         libpoppler-glib8:i386 \
                         libprotobuf-c1:amd64 \
                         libproxy1v5:amd64 \
                         libproxy1v5:i386 \
                         libpsl5:amd64 \
                         libpsl5:i386 \
                         libraw1394-11:amd64 \
                         libraw1394-11:i386 \
                         librsvg2-2:amd64 \
                         librsvg2-2:i386 \
                         librtmp1:amd64 \
                         librtmp1:i386 \
                         libsamplerate0:amd64 \
                         libsamplerate0:i386 \
                         libsane1:amd64 \
                         libsane1:i386 \
                         libsane-common:amd64 \
                         libsane-common:i386 \
                         libsasl2-2:amd64 \
                         libsasl2-2:i386 \
                         libseccomp2:amd64 \
                         libsemanage1:amd64 \
                         libsensors5:amd64 \
                         libsensors5:i386 \
                         libsepol1:amd64 \
                         libshine3:amd64 \
                         libshine3:i386 \
                         libshout3:amd64 \
                         libshout3:i386 \
                         libslang2:amd64 \
                         libslang2:i386 \
                         libsmartcols1:amd64 \
                         libsnappy1v5:amd64 \
                         libsnappy1v5:i386 \
                         libsndfile1:amd64 \
                         libsndio7.0:amd64 \
                         libsndio7.0:i386 \
                         libsnmp40:amd64 \
                         libsnmp40:i386 \
                         libsoup2.4-1:amd64 \
                         libsoup2.4-1:i386 \
                         libsoxr0:amd64 \
                         libsoxr0:i386 \
                         libspeex1:amd64 \
                         libspeex1:i386 \
                         libsqlite3-0:amd64 \
                         libsqlite3-0:i386 \
                         libss2:amd64 \
                         libssh2-1:amd64 \
                         libssh2-1:i386 \
                         libssl1.1:amd64 \
                         libssl1.1:i386 \
                         libstb0:amd64 \
                         libstb0:i386 \
                         libstdc++6:amd64 \
                         libstdc++6:i386 \
                         libswresample3:amd64 \
                         libswresample3:i386 \
                         libsystemd0:amd64 \
                         libtag1v5-vanilla:amd64 \
                         libtag1v5-vanilla:i386 \
                         libtasn1-6:amd64 \
                         libthai0:amd64 \
                         libthai0:i386 \
                         libtheora0:amd64 \
                         libtheora0:i386 \
                         libtiff5:amd64 \
                         libtiff5:i386 \
                         libtirpc3:amd64 \
                         libtwolame0:amd64 \
                         libtwolame0:i386 \
                         libudev1:amd64 \
                         libunistring2:amd64 \
                         libunwind8:amd64 \
                         libunwind8:i386 \
                         libusb-1.0-0:amd64 \
                         libusb-1.0-0:i386 \
                         libuuid1:amd64 \
                         libuv1:amd64 \
                         libv4l-0:amd64 \
                         libv4l-0:i386 \
                         libv4lconvert0:amd64 \
                         libv4lconvert0:i386 \
                         libva2:amd64 \
                         libva2:i386 \
                         libva-drm2:amd64 \
                         libva-drm2:i386 \
                         libva-x11-2:amd64 \
                         libva-x11-2:i386 \
                         libvdpau1:amd64 \
                         libvdpau1:i386 \
                         libvdpau-va-gl1:amd64 \
                         libvdpau-va-gl1:i386 \
                         libvisual-0.4-0:amd64 \
                         libvisual-0.4-0:i386 \
                         libvkd3d1:amd64 \
                         libvkd3d1:i386 \
                         libvorbis0a:amd64 \
                         libvorbisenc2:amd64 \
                         libvpx6:amd64 \
                         libvpx6:i386 \
                         libvulkan1:amd64 \
                         libvulkan1:i386 \
                         libwavpack1:amd64 \
                         libwavpack1:i386 \
                         libwayland-client0:amd64 \
                         libwayland-cursor0:amd64 \
                         libwayland-egl1:amd64 \
                         libwayland-server0:amd64 \
                         libwebp6:amd64 \
                         libwebp6:i386 \
                         libwebpmux3:amd64 \
                         libwebpmux3:i386 \
                         libwrap0:amd64 \
                         libx264-160:amd64 \
                         libx264-160:i386 \
                         libx265-192:amd64 \
                         libx265-192:i386 \
                         libxau6:amd64 \
                         libxcb1:amd64 \
                         libxcb-dri2-0:amd64 \
                         libxcb-dri2-0:i386 \
                         libxcb-dri3-0:amd64 \
                         libxcb-dri3-0:i386 \
                         libxcb-glx0:amd64 \
                         libxcb-glx0:i386 \
                         libxcb-present0:amd64 \
                         libxcb-present0:i386 \
                         libxcb-randr0:amd64 \
                         libxcb-randr0:i386 \
                         libxcb-render0:amd64 \
                         libxcb-render0:i386 \
                         libxcb-shm0:amd64 \
                         libxcb-shm0:i386 \
                         libxcb-sync1:amd64 \
                         libxcb-sync1:i386 \
                         libxcb-xfixes0:amd64 \
                         libxcb-xfixes0:i386 \
                         libxdamage1:amd64 \
                         libxdamage1:i386 \
                         libxdmcp6:amd64 \
                         libxfixes3:amd64 \
                         libxinerama1:amd64 \
                         libxkbcommon0:amd64 \
                         libxml2:amd64 \
                         libxml2:i386 \
                         libxpm4:amd64 \
                         libxpm4:i386 \
                         libxslt1.1:amd64 \
                         libxslt1.1:i386 \
                         libxss1:amd64 \
                         libxtables12:amd64 \
                         libxv1:amd64 \
                         libxv1:i386 \
                         libxvidcore4:amd64 \
                         libxvidcore4:i386 \
                         libxxhash0:amd64 \
                         ocl-icd-libopencl1:amd64 \
                         ocl-icd-libopencl1:i386

dpkg --purge --force-all mesa-va-drivers:amd64 \
                         mesa-va-drivers:i386 \
                         mesa-vdpau-drivers:amd64 \
                         mesa-vdpau-drivers:i386 \
                         mesa-vulkan-drivers:amd64 \
                         mesa-vulkan-drivers:i386 \
                         i965-va-driver:amd64 \
                         i965-va-driver:i386 \
                         intel-media-va-driver:amd64 \
                         intel-media-va-driver:i386 \
                         va-driver-all:amd64 \
                         va-driver-all:i386 \
                         vdpau-driver-all:amd64 \
                         vdpau-driver-all:i386

dpkg --purge --force-all sane-utils:amd64 sane-utils:i386
dpkg --purge --force-all gpgv e2fsprogs avahi-daemon uuid-runtime cabextract hostname passwd 
dpkg --purge --force-all ipp-usb:amd64 ipp-usb:i386
dpkg --purge --force-all acl
dpkg --purge --force-all apt login
dpkg --purge --force-all openssl # keep?
dpkg --purge --force-all mawk:amd64 mawk:i386
dpkg --purge --force-all libcrypt1:amd64 libcrypt1:i386 perl perl-modules-5.32
dpkg --purge --force-all util-linux sed grep gzip iproute2 tar dmsetup dbus # keep?

# Remove stuff that spans many packages
rm -rf /var/log
rm -rf /var/lib/apt
rm -rf /var/lib/dpkg
rm -rf /usr/share/man
rm -rf /usr/share/doc
rm -rf /usr/share/locale

rm -rf /usr/lib/x86_64-linux-gnu/perl-base  /usr/lib/x86_64-linux-gnu/perl
