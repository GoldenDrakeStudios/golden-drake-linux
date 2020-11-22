#!/usr/bin/env bash

################################################################################
# Golden Drake Linux: configure_quick.sh
#
# Copyright (c) 2020 Golden Drake Studios https://goldendrakestudios.com
#
# Forked from Anarchy https://gitlab.com/anarchyinstaller
#
# License: GPL v2.0
################################################################################

quick_install() {
    case "${install_opt}" in
        GDL-Desktop)    kernel="linux"
                        sh="/usr/bin/zsh"
                        shrc="${default}"
                        bootloader="grub"
                        net_util="networkmanager"
                        enable_nm=true
                        multilib=true
                        dhcp=true
                        desktop=true
                        base_install="base-devel linux linux-headers zsh zsh-syntax-highlighting grub dialog networkmanager wireless_tools wpa_supplicant os-prober ${base_defaults} "
                        if "${bluetooth}" ; then
                            base_install+="bluez bluez-utils pulseaudio-bluetooth "
                            enable_bt=true
                        fi
                        if "${enable_f2fs}" ; then
                            base_install+="f2fs-tools "
                        fi
                        if "${UEFI}" ; then
                            base_install+="efibootmgr "
                        fi
                        quick_desktop
                        base_install+="${DE} "
        ;;
        GDL-Desktop-LTS)    kernel="linux-lts"
                            sh="/usr/bin/zsh"
                            shrc="${default}"
                            bootloader="grub"
                            net_util="networkmanager"
                            enable_nm=true
                            multilib=true
                            dhcp=true
                            desktop=true
                            base_install="base-devel linux-lts linux-lts-headers zsh zsh-syntax-highlighting grub dialog networkmanager wireless_tools wpa_supplicant os-prober ${base_defaults} "
                            if "${bluetooth}" ; then
                                base_install+="bluez bluez-utils pulseaudio-bluetooth "
                                enable_bt=true
                            fi
                            if "${enable_f2fs}" ; then
                                 base_install+="f2fs-tools "
                            fi
                            if "${UEFI}" ; then
                                base_install+="efibootmgr "
                            fi
                            quick_desktop
                            base_install+="${DE} "
        ;;
        GDL-Server)     kernel="linux"
                        sh="/usr/bin/zsh"
                        shrc="${default}"
                        bootloader="grub"
                        net_util="networkmanager"
                        enable_nm=true
                        multilib=true
                        dhcp=true
                        base_install="base-devel linux openssh linux-headers zsh zsh-syntax-highlighting grub dialog wireless_tools wpa_supplicant os-prober ${base_defaults} "
                        if "${bluetooth}" ; then
                            base_install+="bluez bluez-utils pulseaudio-bluetooth "
                            enable_bt=true
                        fi
                        if "${enable_f2fs}" ; then
                            base_install+="f2fs-tools "
                        fi
                        if "${UEFI}" ; then
                            base_install+="efibootmgr "
                        fi
        ;;
        GDL-Server-LTS)     kernel="linux-lts"
                            sh="/usr/bin/zsh"
                            shrc="${default}"
                            bootloader="grub"
                            net_util="networkmanager"
                            enable_nm=true
                            multilib=true
                            dhcp=true
                            base_install="base-devel openssh linux-lts linux-lts-headers zsh zsh-syntax-highlighting grub dialog wireless_tools wpa_supplicant os-prober ${base_defaults} "
                            if "${bluetooth}" ; then
                                base_install+="bluez bluez-utils pulseaudio-bluetooth "
                                enable_bt=true
                            fi
                            if "${enable_f2fs}" ; then
                                 base_install+="f2fs-tools "
                            fi
                            if "${UEFI}" ; then
                                base_install+="efibootmgr "
                            fi
        ;;
    esac
}

quick_desktop() {
    while (true) ; do
        de=$(dialog --ok-button "${done_msg}" --cancel-button "${cancel}" --menu "${environment_msg}" 14 60 5 \
            "GDL-budgie"        "${de24}" \
            "GDL-cinnamon"      "${de23}" \
            "GDL-gnome"         "${de22}" \
            "GDL-openbox"       "${de18}" \
            "GDL-xfce4"         "${de15}" 3>&1 1>&2 2>&3)
        if [ -z "${de}" ]; then
            if (dialog --yes-button "${yes}" --no-button "${no}" --yesno "\n${desktop_cancel_msg}" 10 60) then
                return
            fi
        else
            break
        fi
    done
    if ! (</etc/pacman.conf grep "gdl-local"); then
                 sed -i -e '$a\\n[gdl-local]\nServer = file:///usr/share/gdl/pkg\nSigLevel = Never' /etc/pacman.conf
    fi
    case "${de}" in
        "GDL-xfce4")        config_env="${de}"
                            start_term="exec startxfce4"
                            DE+="xfce4 xfce4-goodies ${extras} "
        ;;
        "GDL-budgie")       config_env="${de}"
                            start_term="export XDG_CURRENT_DESKTOP=Budgie:GNOME ; exec budgie-desktop"
                            DE+="budgie-desktop mousepad terminator nautilus gnome-backgrounds gnome-control-center ${extras} "
        ;;
        "GDL-cinnamon")     config_env="${de}"
                            DE+="cinnamon cinnamon-translations gnome-terminal file-roller p7zip zip unrar terminator ${extras} "
                            start_term="exec cinnamon-session"
        ;;
        "GDL-gnome")        config_env="${de}"
                            start_term="exec gnome-session"
                            DE+="gnome gnome-extra terminator ${extras} "
        ;;
        "GDL-openbox")      config_env="${de}"
                            start_term="exec openbox-session"
                            DE+="openbox thunar thunar-volman xfce4-terminal xfce4-panel xfce4-whiskermenu-plugin xcompmgr transset-df obconf lxappearance-obconf wmctrl gxmessage xfce4-pulseaudio-plugin xfdesktop xdotool opensnap ristretto oblogout obmenu-generator polkit-gnome ${extras} "
        ;;
    esac
    while (true) ; do
        if "${VM}" ; then
            case "${virt}" in
                vbox)   GPU="virtualbox-guest-utils virtualbox-guest-dkms "
               ;;
               vmware)  GPU="xf86-video-vmware xf86-input-vmmouse open-vm-tools net-tools gtkmm mesa mesa-libgl"
               ;;
               hyper-v) GPU="xf86-video-fbdev mesa-libgl"
               ;;
               *)       GPU="xf86-video-fbdev mesa-libgl"
               ;;
            esac
            break
        else
            GPU="${default_GPU} mesa-libgl"
            break
        fi
    done
    DE+="${GPU} xdg-user-dirs xorg-server xorg-apps xorg-xinit xterm ttf-dejavu gvfs gvfs-smb gvfs-mtp pulseaudio pavucontrol pulseaudio-alsa alsa-utils unzip xf86-input-libinput lightdm-gtk-greeter lightdm-gtk-greeter-settings "
    if [ "${net_util}" == "networkmanager" ] ; then
        if (<<<"${DE}" grep "plasma" &> /dev/null); then
            DE+="plasma-nm "
        else
            DE+="network-manager-applet "
        fi
    fi
    if "${enable_bt}" ; then
        DE+="blueman "
    fi
    DM="lightdm"
    enable_dm=true
}
