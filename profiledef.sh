#!/bin/bash
#
# Profile for ISO creation. Modified from 'configs/releng/profiledef.sh' here:
# https://gitlab.archlinux.org/archlinux/archiso/
#
# shellcheck disable=SC2034

iso_name="gdl"
iso_label="GDL_$(date +%Y%m%d)"
iso_publisher="Golden Drake Studios <https://goldendrakestudios.com>"
iso_application="Golden Drake Linux - Arch Linux Installer"
iso_version="$(grep 'readonly GDL' airootfs/etc/gdl.conf \
  | tr -d "readonly GDL_VERSION='")"
install_dir="gdl"
buildmodes=('iso')
bootmodes=(
  'bios.syslinux'
  'uefi.systemd-boot'
)
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=(
  '-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M'
)
bootstrap_tarball_compression=(
  'zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19'
)
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/share/gdl/extra/xfce/toggle-touchpad"]="0:0:755"
  ["/usr/bin/gdl"]="0:0:755"
)
