#!/bin/bash
# shellcheck disable=SC2034

iso_name="gdl"
iso_label="GDL_$(date +%Y%m%d)"
iso_publisher="Golden Drake Studios <https://goldendrakestudios.com>"
iso_application="Golden Drake Linux - Arch Linux Installer"
iso_version="$(grep ^GDL_VER airootfs/etc/gdl.conf | tr -d "GDL_VERSION='")"
install_dir="gdl"
buildmodes=('iso')
bootmodes=(
  'bios.syslinux.mbr'
  'bios.syslinux.eltorito'
  'uefi-x64.systemd-boot.esp'
  'uefi-x64.systemd-boot.eltorito'
)
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=(
  '-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M'
)
file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/root"]="0:0:0750"
  ["/root/.automated_script.sh"]="0:0:0755"
  ["/usr/local/bin/choose-mirror"]="0:0:0755"
  ["/usr/local/bin/Installation_guide"]="0:0:0755"
  ["/usr/local/bin/livecd-sound"]="0:0:0755"
  ["/usr/share/gdl/extra/xfce/toggle-touchpad"]="0:0:0755"
  ["/usr/bin/gdl"]="0:0:0755"
)
