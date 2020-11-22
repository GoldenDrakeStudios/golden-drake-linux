# Structure

The contents of this folder are used to build the docker image/container needed
for compiling the Golden Drake Linux (GDL) ISO.

# Building image

Docker image contains `add-aur.sh` and `setup.sh` files.
`docker-compile.sh` would be executed from inside container but it is not embedded into image/container.

To build a new image from `project root` run:

```bash
$ docker build -t gdl:latest .
```

To remove image:

```bash
$ docker rmi gdl:latest
```

# Publishing image (optional)

If you will, you can push created image to docker hub. GDL doesn't maintain an
official docker image.

```bash
$ docker tag gdl:latest <username>/gdl:latest
$ docker tag <username>/gdl:latest <username>/gdl:"$(date +%F)"
```

Publish image:

```bash
$ docker login
# Enter username/password
$ docker push <username>/gdl:"$(date +%F)"
$ docker push <username>/gdl:latest
```

Replace `<username>` with your own `username` on docker hub.

# Compiling ISO

It is recommended to run the `compile.sh` script from `project root` with `-d` flag. If `gdl:latest` docker image doesn't exist, it would be created:

```bash
$ ./compile.sh -d
```

To build an `ISO` image using [Docker](https://www.docker.com) you need to map project root folder to `/gdl` inside docker container to do so run the following command from `project root`:

```bash
$ docker run --rm --privileged \
    --device-cgroup-rule='b 7:* rmw' \
    -v "${PWD}":/project \
    -e gdl_iso_label=GDL10 \
    -e gdl_iso_release=0.0.1 \
    gdl:latest
```

When compilation is completed you can find GDL `ISO` image under `[project root]/out`.

You can start a fresh container and walk trough the process with:

```bash
$ docker run --rm --privileged \
    --device-cgroup-rule='b 7:* rmw' \
    -v "${PWD}":/project \
    -e gdl_iso_label=GDL10 \
    -e gdl_iso_release=0.0.1 \
    -it gdl:latest
```

# Testing ISO

Use a virtualization software to test GDL bootable `ISO`.

For example using [QEMU](https://www.qemu.org) without a hard-disk on `Arch Linux` the command is like:

```bash
$ qemu-system-x86_64 -m 2048M -cdrom ./out/gdl-0.0.1-x86_64.iso
```

Replace `gdl-0.0.1-x86_64.iso` with desired GDL ISO in above command.

# Known issues

- [WARNING:](https://unix.stackexchange.com/questions/460043/how-can-i-successfully-build-an-archiso-image-airootfs-is-not-a-mountpoint) work/x86_64/airootfs is not a mountpoint. This may have undesirable side effects.
