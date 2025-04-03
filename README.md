<p align="center"><img src="images/banner.svg" title="Golden Drake"></p>

# Golden Drake Linux

## Table of contents

- [About](#about)
- [Features](#features)
  - [Desktop environment](#desktop-environment-de)
  - [Software](#software)
  - [Partitioning](#partitioning)
    - [Swap and hibernation](#swap-and-hibernation)
    - [File systems](#file-systems)
  - [Kernel](#kernel)
  - [Languages](#languages)
- [Minimum system requirements](#minimum-system-requirements)
- [Using the installer](#using-the-installer)
- [Reporting issues](#reporting-issues)
- [Contributing](#contributing)
- [Compiling](#compiling)
- [License](#license)

## About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is a custom version of [Arch Linux](https://archlinux.org/) designed for gaming and game development. Strictly speaking, GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution): it's simply a convenient method for installing Arch with certain packages, configurations, and theming and thus it only utilizes the standard Arch repositories along with the [Arch User Repository (AUR)](https://wiki.archlinux.org/title/Arch_User_Repository). GDL is a highly-modified fork of the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer) with additional inspiration from [archdi-pkg](https://github.com/MatMoul/archdi-pkg), [ArchLabs](https://bitbucket.org/archlabslinux/installer/src/master/), [Manjaro](https://gitlab.manjaro.org/profiles-and-settings), and other sources. The installer ISO is built using [Archiso](https://wiki.archlinux.org/index.php/Archiso) and the installation process uses [dialog](https://en.wikipedia.org/wiki/Dialog_(software)) for a visually appealing TUI (text-based UI, a.k.a., terminal UI).

<p align="center"><a href="https://youtu.be/t83a5YwL_KQ" target="_blank" rel="noopener"><img src="https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-youtube-link.jpg" title="GDL installation demo. Click to watch!"></a></p>

GDL is a side project of indie game development studio [Golden Drake Studios (GDS)](https://goldendrakestudios.com/), with updates and support provided by GDS's founder, [David C. Drake](https://davidcdrake.com/). We hope you'll enjoy it, provide constructive feedback, and support our ongoing work on this and other projects through [Patreon](https://patreon.com/theDrake/), but please note that GDL is provided without any warranty and, if it doesn't offer what you're looking for, we recommend checking out another tried-and-true Arch installer, such as [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases), [ArchLabs](https://archlabslinux.com/get/), or a pure [Arch Linux ISO](https://archlinux.org/download/). For a more beginner-friendly Arch-based experience, check out [Garuda Linux](https://garudalinux.org/), [EndeavourOS](https://endeavouros.com/), or [Manjaro](https://manjaro.org/). Looking beyond the Arch family, we can also recommend [Fedora](https://getfedora.org/en/workstation/) (inc. [Spins](https://spins.fedoraproject.org/) and [Labs](https://labs.fedoraproject.org/)), [openSUSE](https://opensuse.org/), and [Debian](https://debian.org/) along with some of its derivatives, such as [Linux Mint Debian Edition (LMDE)](https://linuxmint.com/download_lmde.php) and [MX Linux](https://mxlinux.org/).

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other contexts.)

## Features

### Desktop environment (DE)

Four popular DEs, each lovingly customized for beauty and usability, are available during installation (follow the links for custom keyboard shortcuts and other details):

DE | Screenshot
--- | ---
[KDE Plasma](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/KDE-Plasma), with [SDDM](https://wiki.archlinux.org/title/SDDM) as the display manager. | [![Screenshot of GDL's KDE Plasma environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-kde-plasma-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-kde-plasma.jpg "KDE Plasma. Click to enlarge!")
[GNOME](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/GNOME), with [GDM](https://wiki.archlinux.org/title/GDM) as the display manager. | [![Screenshot of GDL's GNOME environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-gnome-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-gnome.jpg "GNOME. Click to enlarge!")
[Cinnamon](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Cinnamon), with [LightDM](https://wiki.archlinux.org/title/LightDM) as the display manager. | [![Screenshot of GDL's Cinnamon environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-cinnamon-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-cinnamon.jpg "Cinnamon. Click to enlarge!")
[Xfce](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Xfce), with [LightDM](https://wiki.archlinux.org/title/LightDM) as the display manager. | [![Screenshot of GDL's Xfce environment](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-xfce-small.jpg)](https://raw.githubusercontent.com/wiki/GoldenDrakeStudios/golden-drake-linux/images/gdl-xfce.jpg "Xfce. Click to enlarge!")

If LightDM is your [display manager](https://wiki.archlinux.org/title/Display_manager), a secure "Guest Session" option is made available courtesy of [`lightdm-guest-account`](https://aur.archlinux.org/packages/lightdm-guest-account). This is useful when you want to let someone briefly use your computer while ensuring your system and data remain safe: a temporary guest user with limited capabilities is created when they log in, then deleted (along with all associated data) when they log out (the "Switch User" feature should _not_ be used during the guest session as they won't be able to return to that session).

All DEs include a custom [`.bashrc`](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/extra/skel/.bashrc) file to provide the following while in a terminal:

- A `roll` function for tabletop gaming or anytime random numbers are desired: type `roll 1 20` to roll 1d20, `roll 2 4` to roll 2d4, `roll 3 6` to roll 3d6 (or just `roll 3` as six-sided dice is the default), and so on.
- Functions for creating and extracting archive files: `maketarxz`, `maketargz`, `makezip`, and `extract`.
- An `mcd` function for creating a directory and immediately moving into it.
- Aliases to improve some basic commands, facilitate a few important tasks (`yayup` to check for Arch news before updating software, `yaycleanup` to remove old dependencies and cache files, `updatemirrors`, `updategrub`, etc.), and provide more convenient access to features of some of the fun terminal programs listed below.

### Software

Category | Details
--- | ---
Games | <ul><li>A wide variety of games are optionally available during installation, including:</li><ul><li>First-person shooters: [_Xonotic_](https://en.wikipedia.org/wiki/Xonotic), [_OpenArena_](https://en.wikipedia.org/wiki/OpenArena), [_Sauerbraten_](https://en.wikipedia.org/wiki/Cube_2:_Sauerbraten), etc.</li><li>Platformers: [_SuperTux_](https://en.wikipedia.org/wiki/SuperTux), [_Prince of Persia_](https://github.com/NagyD/SDLPoP), [_Frogatto_](https://en.wikipedia.org/wiki/Frogatto_%26_Friends), [_ASCIIpOrtal_](https://github.com/cymonsgames/ASCIIpOrtal), etc.</li><li>Real-time strategy: [_0 A.D._](https://en.wikipedia.org/wiki/0_A.D._(video_game)), [_Widelands_](https://en.wikipedia.org/wiki/Widelands), [_Warzone 2100_](https://en.wikipedia.org/wiki/Warzone_2100), etc.</li><li>Turn-based strategy: [_Wesnoth_](https://en.wikipedia.org/wiki/The_Battle_for_Wesnoth), [_Pingus_](https://pingus.seul.org/), [_Hedgewars_](https://hedgewars.org/), etc.</li><li>Roleplaying: [_OpenMW_](https://gitlab.com/OpenMW/openmw/), [_Daggerfall Unity_](https://forums.dfworkshop.net/viewtopic.php?f=5&t=2360), [_Rogue_](https://en.wikipedia.org/wiki/Rogue_(video_game)), myriad [roguelikes](https://en.wikipedia.org/wiki/Roguelike), etc.</li><li>Adventure: [_Beneath a Steel Sky_](https://en.wikipedia.org/wiki/Beneath_a_Steel_Sky), [_Zork I-III_](https://en.wikipedia.org/wiki/Zork), [_Zelda: Mystery of Solarus DX_](https://solarus-games.org/fr/games/the-legend-of-zelda-mystery-of-solarus-dx/), etc.</li><li>Construction: [_Dwarf Fortress_](https://bay12games.com/dwarves/), [_Luanti_](https://luanti.org) (formerly _Minetest_), [_LinCity-NG_](https://berlios.de/software/lincity-ng/), etc.</li><li>Racing: [_SuperTuxKart_](https://en.wikipedia.org/wiki/SuperTuxKart), [_Armagetron_](https://en.wikipedia.org/wiki/Armagetron_Advanced), [_TORCS_](https://en.wikipedia.org/wiki/TORCS), etc.</li></ul></ul>
Game management | <ul><li>If [Lutris](https://lutris.net/) (or another [Wine](https://winehq.org/)-centric package, such as [Bottles](https://usebottles.com/)) is selected, GDL also installs a set of packages commonly required for various Windows apps/games, including all the prerequisites for Lutris-assisted installation of [Blizzard Battle.net](https://lutris.net/games/battlenet/), providing access to _Overwatch_, _World of Warcraft_, _Hearthstone_, _Starcraft II_, _Diablo III_, etc.</li><li>[Steam](https://store.steampowered.com/), [itch.io](https://itch.io/), [Heroic](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher), [RetroArch](https://retroarch.com/), etc., can also be selected to provide even more access to an endless variety of games.</li><li>[GameMode](https://github.com/FeralInteractive/gamemode) (inc. `lib32-gamemode`) is installed and configured for easy performance optimization via `gamemoderun [app]` (automatic for anything played through [Lutris](https://lutris.net/)).</li><ul><li>For systems with an NVIDIA graphics card plus another GPU, such as an Intel iGPU, `GAMEMODERUNEXEC=prime-run` is added to `/etc/environment` to activate [PRIME render offload](https://wiki.archlinux.org/title/PRIME#PRIME_render_offload) for any app run via `gamemoderun [app]`, ensuring the NVIDIA card does all the heavy lifting for its graphical needs.</li><li>For graphically-intensive Steam games, add `gamemoderun %command%` to each game's _Properties > General > Launch Options_.</li></ul><li>Other gaming-related apps are also available, such as [OBS Studio](https://obsproject.com/) to record and stream, [Discord](https://discord.com/) to discuss and collaborate, and [MangoHud](https://github.com/flightlessmango/MangoHud) to monitor performance and temperatures.</li></ul>
Game development | <ul><li>Engines: [Godot](https://godotengine.org/), [Unreal](https://unrealengine.com/), [Unity](https://unity.com/download), [LÖVE](https://love2d.org/), [Spring](https://springrts.com/), [Solarus](https://solarus-games.org/), etc.</li><li>Art: [Gimp](https://gimp.org/), [Inkscape](https://inkscape.org/), [LibreSprite](https://libresprite.github.io/), [Goxel](https://goxel.xyz/), [Blender](https://blender.org/), [Tiled](https://mapeditor.org/), etc.</li><li>Audio/video: [Audacity](https://audacityteam.org/), [LMMS](https://lmms.io/), [Kdenlive](https://kdenlive.org/), [OpenShot](https://openshot.org/), etc.</li></ul>
Reading & writing | <ul><li>[LibreOffice](https://libreoffice.org/) for spreadsheets, word processing, presentations, etc. (for a thoroughly dark theme, go to _Tools > Options > Application Colors_, open the drop-down menu labeled "Automatic:", and select "Dark").</li><li>[Foliate](https://johnfactotum.github.io/foliate/) for general eBook reading (EPUB, Mobipocket, Kindle, FictionBook, and comic book archive formats).</li><li>[Okular](https://apps.kde.org/okular/) (KDE Plasma), [Evince](https://wiki.gnome.org/Apps/Evince) (GNOME), [Xreader](https://github.com/linuxmint/xreader) (Cinnamon), or [Atril](https://github.com/mate-desktop/atril) (Xfce) for PDFs.</li><li>Offline command line access to the [ArchWiki](https://wiki.archlinux.org/), both during and after installation, via `wiki-search [query]` courtesy of [`arch-wiki-lite`](http://kmkeen.com/arch-wiki-lite/).</li></ul>
Listening & watching | <ul><li>[Audacious](https://audacious-media-player.org/) for music and audiobooks.</li><li>[VLC](https://videolan.org/vlc/) (KDE Plasma), [Totem](https://wiki.gnome.org/Apps/Videos) (GNOME), or [mpv](https://mpv.io/) (Cinnamon/Xfce) for videos.</li><li>[PulseAudio](https://freedesktop.org/wiki/Software/PulseAudio/), [PipeWire](https://pipewire.org/), all the [GStreamer](https://gstreamer.freedesktop.org/) multimedia plugins, plus a [MIDI](https://wiki.archlinux.org/title/MIDI) soundfont.</li></ul>
Misc. | <ul><li>AUR helper `yay` (`yay-bin`) for convenient access to [AUR software](https://aur.archlinux.org/packages/).</li><li>One or more programs for monitoring GPU usage, according to GPU type(s) detected: `nvtop` (works for all GPU brands), `radeontop`, and/or `intel-gpu-tools` (providing `intel_gpu_top`).<li>A variety of fun terminal programs, including `asciiquarium`, `cmatrix`, `cbonsai`, `cowsay`, `lolcat`, `boxes`, `figlet`, `toilet`, and `nms` (["No more secrets,"](https://github.com/bartobri/no-more-secrets) to recreate the data decryption effect from the 1992 hacker film [_Sneakers_](https://youtube.com/watch?v=F5bAa6gFvLs&t=35s)).</li><li>The [Transmission](https://transmissionbt.com/) BitTorrent client, complete with a Qt or GTK GUI.</li><li>The [Uncomplicated Firewall](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall) (`ufw`), enabled with the default "Home" profile.</li></ul>

### Partitioning

GDL provides three [partitioning](https://wiki.archlinux.org/title/Partitioning) options:

Partitioning method | Details
--- | ---
Automatic | <ul><li>For BIOS systems, a separate `/boot` partition is created (260 MiB). BIOS/GPT systems are also provided a [BIOS boot partition](https://wiki.archlinux.org/title/GRUB#GUID_Partition_Table_(GPT)_specific_instructions) (1 MiB).</li><li>For UEFI systems, `/boot` remains part of the root partition and an EFI system partition (ESP) is created instead, mounted at `/efi` (100-260 MiB, depending on logical block size).</li><li>If desired, a swap partition is created as well (size set by user).</li><li>Overwrites an entire drive, or two if a second drive is selected to house a separate `/home` partition.</li></ul>
Automatic with [LUKS encryption](https://wiki.archlinux.org/title/Data-at-rest_encryption) and [logical volume management (LVM)](https://wiki.archlinux.org/title/LVM) | <ul><li>As of v1.2, GDL employs the [LVM on LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS) approach (encrypt the drive, then create logical volumes) as this facilitates a smoother resume process after hibernation.</li><li>Optionally includes an encrypted logical swap space (size set by user).</li><li>A separate unencrypted `/boot` or `/efi` partition is also created, as described above.</li><li>Overwrites an entire drive, or two if a second drive is selected to house a separate `/home` partition (LVM is not applied to the second drive).</li><li>The </li></ul>
Manual | <ul><li>This option offers the most flexibility and control—including the ability to use multiple drives or only part of a drive—but also the most potential for something to go wrong. Use at your own risk and do your best to ensure you know what you're doing.</li><li>Select an entire drive (e.g., `/dev/sda`) to modify its partition table via `cfdisk`, `fdisk`, or `gdisk`.</li><li>Select a partition (e.g., `/dev/sda1`) to set its mount point (`/`, `/home`, etc.) or activate it as a swap partition. This may involve formatting the partition and selecting its [file system](#file-systems).</li><li>NOTE: GDL's manual partitioning process has some quirks and limitations. It's not perfect and may not satisfy everyone's needs. For example, it currently does _not_ facilitate manual creation of RAID, LVM, or encryption. These limitations can often be sidestepped by preparing your partitions via command line prior to running the installer (and perhaps double-checking and modifying relevant config files after installation), but this isn't guaranteed to work in all use cases.</li></ul>

#### Swap and hibernation

If [hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation) support (suspend to disk) is desired, choose a suitably large swap space during installation. The size needed varies based on actual RAM usage, but to be safe it should probably be **at least** as large as the amount of RAM. If GDL detects the swap space is less than or equal to RAM, it will configure the system to compress the hibernation image as much as possible.

#### File systems

Three [file system](https://wiki.archlinux.org/title/File_systems) options are available for all partitions (except ESPs, which use [FAT32](https://wiki.archlinux.org/title/EFI_system_partition#Format_the_partition)):

- [Btrfs](https://wiki.archlinux.org/title/Btrfs)
- [Ext4](https://wiki.archlinux.org/title/Ext4)
- [XFS](https://wiki.archlinux.org/title/XFS)

[Btrfs](https://wiki.archlinux.org/title/Btrfs) is growing in popularity due to its convenient compression and snapshot capabilities, among other features, and we highly recommend it (unless you want to use a [RAID 5/6](https://wiki.archlinux.org/title/Btrfs#RAID) setup)! GDL automatically sets up Btrfs partitions with excellent mount options, including compression (`compress-force=zstd:2`), and creates appropriate subvolumes with names starting with `@` as is common practice and expected by certain system restore utilities, such as [Timeshift](https://github.com/teejee2008/timeshift).

In fact, if Timeshift is selected during installation (and the root partition uses Btrfs), GDL configures Timeshift to automatically create root subvolume snapshots on a regular basis, including right before software updates (courtesy of [`timeshift-autosnap`](https://gitlab.com/gobonja/timeshift-autosnap)), and snapshots are added to the GRUB menu (thanks to [`grub-btrfs`](https://github.com/Antynea/grub-btrfs)) so you can boot directly into one of them in the unlikely event that your system is "broken" but the GRUB menu is still accessible, allowing you to use Timeshift from within a snapshot to **restore** that (or another) snapshot so you can then reboot into your system as usual. (By default, these snapshots do **not** include the `@home` subvolume, which is generally the right choice: user data backups should probably be handled separately through a secure external drive, remote server, or both.) If the GRUB menu is inaccessible, then you must boot into a live Linux environment (such as the GDL installer) via [USB flash drive](#using-the-installer) to fix your system.

### Kernel

GDL utilizes the standard [Linux kernel](https://wiki.archlinux.org/index.php/Kernel). Yes, there are a few interesting [custom kernels](https://wiki.archlinux.org/index.php/Kernel#Unofficial_kernels), such as xanmod and tkg, that can in some cases provide slight improvements to gaming performance, RAM usage, etc., but they can also reduce stability and make upgrading less convenient, so, for now, GDL only installs the vanilla kernel. You are, of course, free to install additional kernels as you see fit.

### Languages

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

Options for Chinese (中文), Japanese (日本語), and Korean (한국어) fonts were explored, but sadly there is currently no way to provide them within the minimal text-based environment of the installer. For your new system, however, [IBus](https://wiki.archlinux.org/title/IBus) packages for convenient keyboard input in Chinese (`ibus-libpinyin` or `ibus-chewing`), Japanese (`ibus-kkc`), and Korean (`ibus-hangul`) are available during installation and, if selected, are configured for you (after login, use <kbd>Ctrl</kbd>+<kbd>Space</kbd> or <kbd>Super</kbd>+<kbd>Space</kbd> to change input language at any time).

## Minimum system requirements

Hardware | Requirements
--- | ---
CPU | 1 GHz dual-core 64-bit processor (3 GHz quad-core recommended)
GPU | Whatever you need for the type of games you want to play/develop!
Memory | 2 GB RAM (16 GB recommended)
Storage | 20 GB of HDD/SSD space (1 TB recommended)

## Using the installer

You can try GDL safely by downloading the [latest ISO](https://github.com/GoldenDrakeStudios/golden-drake-linux/releases) and using it as a virtual CD/DVD in a virtual machine. When you're ready to use it on a physical machine, you'll most likely want to use a USB flash drive as your installation medium, so here are some useful steps for that process in Linux (for alternative methods, including Windows and macOS options, consult [this ArchWiki article](https://wiki.archlinux.org/title/USB_flash_installation_medium) or search online using a query such as ["create bootable USB from ISO"](https://duckduckgo.com/?q=create+bootable+USB+from+ISO)):

1. First, back up _all_ important data from _all_ devices involved in this process.
2. Download the [latest ISO](https://github.com/GoldenDrakeStudios/golden-drake-linux/releases).
3. Insert the USB flash drive you want to use as the install medium. (**NOTE:** All data on the flash drive will be erased!)
4. In a terminal, use the `lsblk` command to _carefully_ determine the exact device name associated with your flash drive (something like `sdc`, `sdd`, etc.). If it's mounted, unmount it.
5. _Carefully_ use the `dd` command shown below (which may require `sudo` for elevated privileges), replacing `path/to/file.iso` with the actual path to the ISO and replacing the `x` at the end of `/dev/sdx` with the letter associated with your flash drive as determined in step 4 (do **not** include a number and, above all, do **not** use the wrong device name). _**CAUTION:** Using the wrong device name could result in extensive data loss and/or destruction of your current operating system!_<br>
`dd bs=4M conv=fsync oflag=direct status=progress if=path/to/file.iso of=/dev/sdx`

That's it! Now you can boot from your USB flash drive to perform a fresh install of Golden Drake Linux.

The installer's command line environment can also be used for other purposes, such as fixing a broken system by mounting the appropriate partition(s) in `/mnt` and then running commands within the broken system via [`arch-chroot /mnt [command]`](https://wiki.archlinux.org/title/Chroot).

## Reporting issues

If you encounter an issue that might just be a general hardware/software issue, or you simply have questions about terminology, processes, etc., first check the [ArchWiki](https://wiki.archlinux.org/), [man pages](https://wiki.archlinux.org/title/Man_page), and other resources for relevant information. (Consider this a gentle reminder to [RTFM](https://en.wikipedia.org/wiki/RTFM)...ha!)

If you're confident an issue you've encountered is due to a problem within GDL, please provide a detailed report via [GitHub](https://github.com/GoldenDrakeStudios/golden-drake-linux/issues) or email (support[at]goldendrakestudios[dot]com) and, if convenient, share the log file located at `/root/gdl.log` during installation (or at `~/gdl.log` in your newly-installed system) either as a direct attachment or by running the command `nc termbin.com 9999 < /root/gdl.log` (or `nc termbin.com 9999 < ~/gdl.log` post-installation) and sharing the returned URL.

## Contributing

Feel free to send suggestions, questions, feature requests, etc., to the project maintainer, David C. Drake: drake[at]goldendrakestudios[dot]com

To contribute financially and receive certain benefits, including increased influence over the development of GDL and our indie game projects, please support us through [Patreon](https://patreon.com/theDrake/) or [GitHub Sponsors](https://github.com/sponsors/theDrake) (donations via [Ko-fi](https://ko-fi.com/theDrake), [PayPal](https://paypal.me/DavidCDrake), and [Venmo](https://venmo.com/u/dcdrake) are also greatly appreciated). We are deeply grateful for all our supporters, including:

- [Aina the Khajiit](https://youtube.com/@ainathekhajiit)
- Lucy Rose
- Lyle R.

If you wish to modify or supplement the project's code, feel free to submit a pull request. Please adhere to the following guidelines:

- Follow shell scripting best practices, such as those recommended in [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- Use `"${variable}"` instead of `$variable` (but omit the quotation marks when necessary, i.e., in rare cases when a variable needs to be word-split into multiple strings).
- Name constants and global variables `LIKE_THIS`, other variables (and functions) `like_this`.
- Write comments where needed.
- Use `shellcheck` and thoroughly test your code.
- Write informative commit messages.

If you'd like to provide a new translation or modify an existing [language file](https://github.com/GoldenDrakeStudios/golden-drake-linux/tree/master/lang), that would be wonderful! Please use [english.conf](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/lang/english.conf) as your primary reference.

## Compiling

GDL uses `git-lfs` to manage images, so if you want to `git clone` this repository, ensure `git-lfs` is installed on your system.

To compile within an Arch (or Arch-based) Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). If that fails, or if your Linux environment is not Arch-based, add a `-c` flag to compile in a temporary Arch container via `podman` (e.g., `sudo ./build.sh -c`). Compilation within non-Linux environments, such as Windows, macOS, and FreeBSD, might also be possible in one way or another, but these have not been tested.

Once the build is complete, the ISO and its checksum file are located in an `out` directory.

## License

This project is licensed under the [GNU GPLv2 license](LICENSE).
