<p align="center"><img src="images/banner.svg" title="Golden Drake"></p>

# Golden Drake Linux

## Table of Contents

- [About](#about)
- [Features](#features)
  - [Desktop Environment](#desktop-environment-de)
  - [Software](#software)
  - [Partitioning](#partitioning)
  - [File Systems](#file-systems)
  - [Kernel](#kernel)
  - [Language Support](#language-support)
- [Minimum System Requirements](#minimum-system-requirements)
- [Using the Installer](#using-the-installer)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Compiling](#compiling)
- [License](#license)

## About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is a custom version of [Arch Linux](https://www.archlinux.org/) designed for gamers and game developers. Strictly speaking, GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution): it's simply a convenient method for installing Arch with certain packages, configurations, and theming and thus it only utilizes the standard Arch repositories along with the [Arch User Repository (AUR)](https://wiki.archlinux.org/title/Arch_User_Repository). GDL is a highly-modified fork of the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer/) with additional inspiration from [archdi-pkg](https://github.com/MatMoul/archdi-pkg), [ArchLabs](https://bitbucket.org/archlabslinux/installer/src/master/), [Manjaro](https://gitlab.manjaro.org/profiles-and-settings), and other sources. The installer ISO is built using [Archiso](https://wiki.archlinux.org/index.php/Archiso) and the installation process uses [dialog](https://en.wikipedia.org/wiki/Dialog_(software)) for a visually appealing TUI (text-based UI, a.k.a., terminal UI).

GDL is a side project of indie game development studio [Golden Drake Studios (GDS)](https://goldendrakestudios.com/), with updates and support provided by GDS's founder, [David C. Drake](https://davidcdrake.com/). We hope you'll enjoy it, provide constructive feedback, and support our ongoing work on this and other projects through [Patreon](https://patreon.com/theDrake/), but please note that GDL is provided without any warranty and, if it doesn't offer what you're looking for, we recommend checking out another tried-and-true Arch installer, such as [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases), [ArchLabs](https://archlabslinux.com/get/), or a pure [Arch Linux ISO](https://archlinux.org/download/). For a more beginner-friendly Arch-based experience, we highly recommend [Garuda Linux](https://garudalinux.org/downloads.html), [EndeavourOS](https://endeavouros.com/download/), or [Manjaro](https://manjaro.org/download/). Looking beyond the Arch family, we can also strongly recommend [Fedora](https://getfedora.org/en/workstation/) (inc. [Spins](https://spins.fedoraproject.org/) and [Labs](https://labs.fedoraproject.org/)), [openSUSE](https://www.opensuse.org/), and the [Debian](https://www.debian.org/distrib/)/[Ubuntu](https://ubuntu.com/download/desktop) family (inc. various [Ubuntu flavors](https://ubuntu.com/download/flavours) as well as [Linux Mint](https://www.linuxmint.com/), [Pop!_OS](https://pop.system76.com/), and [MX Linux](https://mxlinux.org/)).

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other Linux-related contexts.)

## Features

### Desktop Environment (DE)

Four popular DEs, each lovingly customized for beauty and usability, are available during installation (follow the links for custom keyboard shortcuts and other details):

Desktop Environment | Screenshot
--- | ---
[KDE Plasma](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/KDE-Plasma), with [SDDM](https://wiki.archlinux.org/title/SDDM) or [LightDM](https://wiki.archlinux.org/title/LightDM) as the display manager.| [![Screenshot of GDL's KDE Plasma environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-kde-plasma-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-kde-plasma.jpg)
[GNOME](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/GNOME), with [GDM](https://wiki.archlinux.org/title/GDM) as the display manager. | [![Screenshot of GDL's GNOME environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-gnome-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-gnome.jpg)
[Cinnamon](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Cinnamon), with [LightDM](https://wiki.archlinux.org/title/LightDM) as the display manager. | [![Screenshot of GDL's Cinnamon environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-cinnamon-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-cinnamon.jpg)
[Xfce](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Xfce), with [LightDM](https://wiki.archlinux.org/title/LightDM) as the display manager. | [![Screenshot of GDL's Xfce environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-xfce-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-xfce.jpg)

If LightDM is set as your [display manager](https://wiki.archlinux.org/title/Display_manager), a secure "Guest Session" option will be available courtesy of [`lightdm-guest-account`](https://aur.archlinux.org/packages/lightdm-guest-account). This is useful when you want to let someone briefly use your computer while ensuring your system and data remain safe: a temporary guest user with limited capabilities is created when they log in, then deleted (along with all associated data) when they log out (the "Switch User" feature should _not_ be used during the guest session as they won't be able to return to that session).

All DEs include a custom [`.bashrc`](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/extra/skel/.bashrc) file to provide the following while in a terminal:

- A `roll` function for tabletop gaming or anytime random numbers are desired: type `roll 1 20` to roll 1d20, `roll 2 4` to roll 2d4, `roll 3 6` to roll 3d6 (or just `roll 3` as six-sided dice is the default), and so on.
- Functions for creating and extracting archive files: `maketarxz`, `maketargz`, `makezip`, and `extract`.
- An `mcd` function for creating a directory and immediately moving into it.
- Aliases to improve some basic commands, facilitate a few important tasks (`updatemirrors`, `updategrub`, `yaycleanup`, etc.), and provide more convenient access to features of some of the fun terminal programs listed below.

### Software

- AUR helper `yay` (`yay-bin`) for convenient access to [AUR software](https://aur.archlinux.org/packages/).
- [GameMode](https://github.com/FeralInteractive/gamemode) (inc. `lib32-gamemode`) for easy performance optimization via `gamemoderun [app]` (automatic for anything played through [Lutris](https://lutris.net/)).
  - For systems with an NVIDIA graphics card plus another GPU, such as an Intel integrated GPU, `GAMEMODERUNEXEC=prime-run` is added to `/etc/environment` so that [PRIME render offload](https://wiki.archlinux.org/title/PRIME#PRIME_render_offload) will activate for any app run via `gamemoderun [app]`, ensuring the NVIDIA card does all the heavy lifting for its graphical needs.
- A wide selection of optional free/libre and open source ([FLOSS](https://www.gnu.org/philosophy/floss-and-foss.en.html)) games and gaming-related software ([OBS Studio](https://obsproject.com/), [MangoHud](https://github.com/flightlessmango/MangoHud), [Discord](https://discord.com/), etc.).
- If [Lutris](https://lutris.net/) (or another [Wine](https://www.winehq.org/)-centric package, such as [Bottles](https://usebottles.com/)) is selected during installation, GDL will also include a set of packages commonly required for various Windows apps/games, including all the prerequisites for Lutris-assisted installation of [Blizzard Battle.net](https://lutris.net/games/battlenet/), providing access to *Overwatch*, *World of Warcraft*, *Hearthstone*, *Starcraft II*, *Diablo III*, etc., all within Linux!
- [Steam](https://store.steampowered.com/), [itch.io](https://itch.io/), [Heroic](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher), [RetroArch](https://www.libretro.com/), etc., can also be selected to provide even more access to an endless variety of games.
  - If `steam` is selected, the optional dependency `steam-native-runtime` will also be installed so you can rely on `steam-native` in those rare cases when the standard `steam` runtime has a problem, such as failing to launch a particular game. If you encounter an issue that isn't solved by switching to `steam-native`, consult these [game-specific](https://wiki.archlinux.org/title/Steam/Game-specific_troubleshooting) and [client-specific](https://wiki.archlinux.org/title/Steam/Troubleshooting) troubleshooting articles and other online resources (especially [ProtonDB](https://www.protondb.com/) for Windows games): in general, you'll quickly discover a solution.
- The [Godot](https://godotengine.org/) game engine, [Unreal Engine](https://www.unrealengine.com/), [Unity Hub](https://unity3d.com/get-unity/download), [Gimp](https://www.gimp.org/), [Inkscape](https://inkscape.org/), [Goxel](https://goxel.xyz/), [Blender](https://www.blender.org/), [Tiled](https://www.mapeditor.org/), [Audacity](https://www.audacityteam.org/), [LibreSprite](https://libresprite.github.io/), and other apps relevant to game art, game programming, and other aspects of game development are also optionally available.
- [LibreOffice](https://www.libreoffice.org/) for spreadsheets, word processing, presentations, etc., with dark theming applied (for light theming, go to *Tools > Options > Application Colors* and change the color scheme from "LibreOffice Dark" to "LibreOffice").
- [Foliate](https://johnfactotum.github.io/foliate/) for general eBook reading (EPUB, Mobipocket, Kindle, FictionBook, and comic book archive formats), [xCHM](https://github.com/rzvncj/xCHM) for CHM files, and either [Okular](https://apps.kde.org/okular/) (KDE Plasma), [Evince](https://wiki.gnome.org/Apps/Evince) (GNOME), [Xreader](https://github.com/linuxmint/xreader) (Cinnamon), or [Atril](https://github.com/mate-desktop/atril) (Xfce) for PDFs.
- [Audacious](https://audacious-media-player.org/) for music and either [VLC](https://www.videolan.org/vlc/) (KDE Plasma), [Totem](https://wiki.gnome.org/Apps/Videos) (GNOME), or [Celluloid](https://celluloid-player.github.io/)/[mpv](https://mpv.io/) (Cinnamon/Xfce) for videos along with [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/), [PipeWire](https://pipewire.org/), and all the [GStreamer](https://gstreamer.freedesktop.org/) multimedia plugins plus a [MIDI](https://wiki.archlinux.org/title/MIDI) soundfont to satisfy all your audio needs.
- A variety of fun terminal programs, including `asciiquarium`, `cmatrix`, `cbonsai`, `cowsay`, `lolcat`, `boxes`, `figlet`, `toilet`, `pipes.sh`, and `nms` ("[No more secrets](https://github.com/bartobri/no-more-secrets)," to recreate the data decryption effect from the 1992 hacker movie [*Sneakers*](https://www.youtube.com/watch?v=F5bAa6gFvLs&t=35s)).
- Offline access to the [ArchWiki](https://wiki.archlinux.org/), both during and after installation, via `wiki-search [query]` (courtesy of [`arch-wiki-lite`](http://kmkeen.com/arch-wiki-lite/)).
- The [Transmission](https://transmissionbt.com/) BitTorrent client, complete with a Qt (KDE Plasma) or GTK (GNOME/Cinnamon/Xfce) GUI.
- The [Uncomplicated Firewall](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall) (`ufw`), preinstalled and enabled.

### Partitioning

GDL provides three [partitioning](https://wiki.archlinux.org/title/Partitioning) options:

Partitioning Method | Details
--- | ---
Automatic | <ul><li>For BIOS systems, a separate `/boot` partition is created (260 MiB). BIOS/GPT systems are also provided a [BIOS boot partition](https://wiki.archlinux.org/title/GRUB#GUID_Partition_Table_(GPT)_specific_instructions) (1 MiB).</li><li>For UEFI systems, `/boot` remains part of the root partition and an EFI system partition (ESP) is created instead, mounted at `/efi` (100-260 MiB, depending on logical block size).</li><li>If desired, a swap partition is created as well (size set by user).</li><li>Operates on a single drive, overwriting the entire drive.</li></ul>
Automatic with [LUKS encryption](https://wiki.archlinux.org/title/Data-at-rest_encryption) and [logical volume management (LVM)](https://wiki.archlinux.org/title/LVM) | <ul><li>Uses the [LUKS on LVM](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_LVM) approach: LVM is set up first, then encryption is applied.</li><li>Includes an encrypted `/tmp` volume (500 MiB) and, optionally, an encrypted logical swap space (size set by user).</li><li>A separate (unencrypted) `/boot` or `/efi` partition is also created, as described above.</li><li>Operates on a single drive, overwriting the entire drive.</li></ul>
Manual | <ul><li>This option offers the most flexibility and control—including the ability to use only part of a given drive and to set up partitions on multiple drives—but also the most potential for something to go wrong. Use at your own risk and do your best to ensure you know what you're doing.</li><li>Select an entire drive (e.g., `/dev/sda`) to modify its partition table via `cfdisk`, `fdisk`, or `gdisk`.</li><li>Select a partition (e.g., `/dev/sda1`) to set its mount point (`/`, `/home`, etc.) or activate it as a swap partition. This may involve formatting the partition and selecting its [file system](#file-system).</li><li>NOTE: GDL's manual partitioning process has some quirks and limitations. It's not perfect and may not satisfy everyone's needs. For example, it currently does **not** facilitate manual creation of RAID, LVM, or encryption. These limitations can often be sidestepped by preparing your partitions via command line prior to running the installer (and perhaps double-checking and modifying relevant config files after installation), but this isn't guaranteed to work in all use cases.</li></ul>

### File Systems

Three [file system](https://wiki.archlinux.org/title/File_systems) options are available for all partitions (except ESPs, which use [FAT32](https://wiki.archlinux.org/title/EFI_system_partition#Format_the_partition)):

- [Ext4](https://wiki.archlinux.org/title/Ext4)
- [Btrfs](https://wiki.archlinux.org/title/Btrfs)
- [XFS](https://wiki.archlinux.org/title/XFS)

Btrfs is growing in popularity due to its convenient compression and snapshot capabilities, among other features, and we highly recommend it (unless you want to use a [RAID 5/6](https://wiki.archlinux.org/title/Btrfs#RAID) setup)! The GDL installer automatically sets up Btrfs partitions with excellent mount options, including compression (`compress-force=zstd:2`), and creates appropriate subvolumes with names starting with `@` as is common practice and expected by certain system restore utilities such as [Timeshift](https://github.com/teejee2008/timeshift).

In fact, if Timeshift is selected during installation (and the root partition uses Btrfs), GDL will configure Timeshift to automatically create root subvolume snapshots on a regular basis, including right before software updates (courtesy of [`timeshift-autosnap`](https://gitlab.com/gobonja/timeshift-autosnap)), and each snapshot will be added to the GRUB menu (thanks to [`grub-btrfs`](https://github.com/Antynea/grub-btrfs)) so you can boot directly into one of them (as a read-only environment) in the unlikely event that your actual (read-write) system is broken, allowing you to then use Timeshift from within the snapshot to _restore_ a snapshot so you can then reboot into your system as usual. (By default, these snapshots will **not** include the `@home` subvolume, which is generally the right choice: user data backups should probably be handled separately through a secure external drive, remote server, or both.)

### Kernel

GDL utilizes the standard [Linux kernel](https://wiki.archlinux.org/index.php/Kernel). Yes, there are a few interesting [custom kernels](https://wiki.archlinux.org/index.php/Kernel#Unofficial_kernels), such as xanmod and tkg, that can in some cases provide slight improvements to gaming performance, RAM usage, etc., but they can also reduce stability and make upgrading less convenient, so, for now, GDL only installs the vanilla kernel. You are, of course, free to install additional kernels as you see fit.

### Language Support

You can select **any** locale/language for your new system, of course, but as for the installer itself, GDL currently supports the following languages:

- Bulgarian (Български)
- Dutch (Nederlands)
- English
- French (Français)
- German (Deutsch)
- Greek (Ελληνικά)
- Hungarian (Magyar)
- Indonesian (bahasa Indonesia)
- Italian (Italiano)
- Latvian (Latviešu)
- Lithuanian (Lietuvių)
- Polish (Polski)
- Portuguese (Português)
- Portuguese, Brazilian (Português do Brasil)
- Romanian (Română)
- Russian (Русский)
- Spanish (Español)
- Swedish (Svenska)

Options for Chinese (中文), Japanese (日本語), and Korean (한국어) fonts have been explored, but sadly there is currently no way to provide them within the minimal text-based environment of the installer. For your new system, however, excellent [IBus](https://wiki.archlinux.org/title/IBus) packages for convenient keyboard input in Chinese (`ibus-libpinyin` or `ibus-chewing`), Japanese (`ibus-kkc`), and Korean (`ibus-hangul`) are available during installation and, if selected, will be configured for you (after login, use Ctrl+Space or Super+Space to change input language at any time).

## Minimum System Requirements

Hardware | Requirements
--- | ---
CPU | 1 GHz dual-core 64-bit processor (3 GHz quad-core recommended)
GPU | Whatever you need for the type of games you want to play/develop!
Memory | 2 GB RAM (16 GB recommended)
Storage | 20 GB of HDD/SSD space (1 TB recommended)

## Using the Installer

You can try GDL safely by downloading the [latest ISO](https://github.com/GoldenDrakeStudios/golden-drake-linux/releases) and using it as a virtual CD-ROM in a virtual machine. When you're ready to use it on a physical machine, you'll most likely want to use a USB flash drive as your installation medium, so here are some useful steps for that process in Linux (for alternative methods, including Windows and macOS options, consult [this ArchWiki article](https://wiki.archlinux.org/title/USB_flash_installation_medium) or search online using a query like ["create bootable USB from ISO"](https://duckduckgo.com/?q=create+bootable+USB+from+ISO)):

1. First, back up _all_ important data from _all_ devices involved in this process.
2. Download the [latest ISO](https://github.com/GoldenDrakeStudios/golden-drake-linux/releases).
3. Insert the USB flash drive you want to use as the install medium. (**NOTE:** All data on the flash drive will be erased later!)
4. In a terminal, use the `lsblk` command to _carefully_ determine the exact device name associated with your flash drive (something like `sdc`, `sdd`, etc.).
5. _Carefully_ use the `dd` command shown below (which may require `sudo` for elevated privileges), replacing `path/to/file.iso` with the actual path to the ISO and replacing the `x` at the end of `/dev/sdx` with the letter associated with your flash drive as determined in step 4 (do **not** include a number and, above all, do **not** use the wrong device name). _**CAUTION:** Using the wrong device name could result in extensive data loss and/or destruction of your current operating system!_<br>
`dd bs=4M conv=fsync oflag=direct status=progress if=path/to/file.iso of=/dev/sdx`

That's it! Now you can boot from that flash drive to perform a fresh installation of Golden Drake Linux (or do some troubleshooting/maintenance via [`arch-chroot`](https://wiki.archlinux.org/title/Chroot), etc.).

## Reporting Issues

If you encounter an issue that might just be a general hardware/software issue, or you simply have questions about terminology, processes, etc., first check the [ArchWiki](https://wiki.archlinux.org/), [Arch Linux Forums](https://bbs.archlinux.org/), [man pages](https://wiki.archlinux.org/title/Man_page), and other resources for relevant information. (Consider this a gentle reminder to [RTFM](https://en.wikipedia.org/wiki/RTFM)...ha!)

If you're confident an issue you've encountered is due to a problem within GDL, please provide a detailed report via [GitHub](https://github.com/GoldenDrakeStudios/golden-drake-linux/issues) or email (support[at]goldendrakestudios[dot]com) and, if convenient, share the installation log located at `/root/gdl.log` either as a direct attachment or by running the command `nc termbin.com 9999 < /root/gdl.log` in the terminal and sharing the returned URL.

## Contributing

Feel free to send suggestions, questions, feature requests, etc., to the project maintainer, David C. Drake: drake[at]goldendrakestudios[dot]com

To contribute financially and receive certain benefits, including increased influence over the development of GDL as well as our indie game projects, please support us through [Patreon](https://patreon.com/theDrake/). Donations via [Ko-fi](https://ko-fi.com/theDrake) are also greatly appreciated.

If you wish to modify or supplement the project's code, feel free to submit a pull request. Please adhere to the following guidelines:

- Follow shell scripting best practices, such as those recommended in [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- Use `"${variable}"` instead of `$variable` (but omit the quotation marks when necessary, i.e., in rare cases when a variable needs to be word-split into multiple strings).
- Constants and global variables should be named `LIKE_THIS`, other variables (and functions) `like_this`.
- Write comments where needed.
- Use `shellcheck` and thoroughly test your code.
- Write informative commit messages.

If you'd like to provide a new translation or modify an existing [language file](https://github.com/GoldenDrakeStudios/golden-drake-linux/tree/master/lang), that would be wonderful! Please use [english.conf](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/lang/english.conf) as your primary reference.

## Compiling

GDL uses `git-lfs` to manage images, so if you want to `git clone` this repository, first ensure `git-lfs` is installed on your system.

To compile in an Arch Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). In other environments, add a `-c` flag to compile in an Arch Linux container via `podman` (e.g., `sudo ./build.sh -c`).

Once the build is complete, the ISO file will be located in an `out` directory.

## License

This project is licensed under the [GNU GPLv2 license](LICENSE).

```
                               .                .
                           ...      .. .          ...
                    ...';:;'      ',';;:'.          ,;:;'...
               ..,,,,;::','.  ..,;:::::::;,.        ''''::;;,;,..
           ..;:;,,;;;;'..,'. ..,;:::;'::::;:'.      '.;..':;;;,,;:,.
         .;::,,;;..;'':.;.,;  ..;:::' ...',.''     .;'',.:'';..;;,,::;.
       ';:;'':,...:.':'.:.;;;.  ..;::;.  ..       .;:,.:.,:..:..',;'';:;'
     ';;;'.;,',,.:..::..:.;;;;;,...'::::;'.  ..',;;;:,.:..:;..:.,;',;.':;;'
   .;;;;.':.'::.;; ,:: ': ,;;;;;;..:::::::; ';;;;;;;:,.:..:;' ;;.::'.:..;;;;.
  ';;;;..:.'::;.:' ;:: .:.';;;;;, ':::::::' ,;;;;;;;:..:..:;, ':.;::..:.';;;;.
 .;;;;;.;,.;::,.:. ;::..:..;;;;;, .:::::::, ';;;;;;;:.':..:;; ':.;::;.,,.;;;;;.
.;;;;;,.:.';::;.:' ;::; ;, ;;;;;;' ':::::::' ';,,,;;, ;, ;:;; ,: ;::;..: ;;;;;;
';;;;;, :.,;:::.;; ,:::..:..;.       ...',;:;.    .;..:.'::;, :,.:::;,.: ,;;;;;.
,;;;;;; ;.,;:::..:..::::.', .      .,::;,'....;'   . ;'.:::;..:.':::;,', ;;;;;;,
,;;;;;;..'';,;:; ;,.:::;'.'.       '..::  .',.,;;.  ''.':::;.;,.::;,;',..;;;;;;,
,;,.  .. ,.   .,'.:.':'    ..         '.,'.  ....  ..    ,:'.:.,,.   ., ..  .,;,
',       ..     ...;.,      .             .'.      .      ;.:...     ..       ,.
.         .        ''                     .:,;.            ,.        .        ..
                    '.                    .;;;'           .'
                     '                     ,' .           '
                     .                    ..              .
```
