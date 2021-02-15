FROM docker.io/archlinux:latest
LABEL maintainer="David C. Drake"
ENV iscontainer="yes"
RUN pacman -Sy --needed --noconfirm reflector
COPY assets /gdl/assets
COPY src build.sh profiledef.sh /gdl/
ENTRYPOINT ["/gdl/build.sh"]
