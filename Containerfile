FROM docker.io/archlinux:latest
LABEL maintainer="Golden Drake Studios <https://goldendrakestudios.com>"
ENV iscontainer="yes"
RUN pacman -Sy --needed --noconfirm reflector
COPY assets /gdl/assets
COPY src build.sh profiledef.sh /gdl/
ENTRYPOINT ["/gdl/build.sh"]
