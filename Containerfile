FROM docker.io/archlinux:latest
LABEL maintainer="Golden Drake Studios <https://goldendrakestudios.com>"
ENV iscontainer="yes"
COPY . /gdl/
ENTRYPOINT ["/gdl/build.sh"]
