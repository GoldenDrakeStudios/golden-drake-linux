<p align="center"><img src="banner.svg" title="Golden Drake"></p>

# Golden Drake Linux

## Table of Contents

- [About](#about)
- [Features](#features)
  - [Desktop Environment](#desktop-environment-de)
  - [Software](#software)
  - [Kernel](#kernel)
  - [Language Support](#language-support)
- [Minimum System Requirements](#minimum-system-requirements)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Compiling](#compiling)
- [License](#license)

## About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is an [Arch Linux](https://www.archlinux.org/) installer designed for gamers and game developers. GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution): it's simply a convenient method for installing a customized version of Arch and thus only utilizes the standard Arch repositories along with the [Arch User Repository (AUR)](https://wiki.archlinux.org/title/Arch_User_Repository). GDL is a highly-modified fork of the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer/) with additional inspiration from [archdi-pkg](https://github.com/MatMoul/archdi-pkg), [ArchLabs](https://bitbucket.org/archlabslinux/installer/src/master/), [Manjaro](https://gitlab.manjaro.org/profiles-and-settings), etc. The installer ISO is built using [Archiso](https://wiki.archlinux.org/index.php/Archiso) and the installation process uses [dialog](https://en.wikipedia.org/wiki/Dialog_(software)) for a visually appealing TUI (text-based UI, a.k.a., terminal UI).

GDL is a side project of indie game development studio [Golden Drake Studios (GDS)](https://goldendrakestudios.com/), with updates and support provided by GDS's founder, [David C. Drake](https://davidcdrake.com/). We hope you'll enjoy it, provide constructive feedback, and support our ongoing work on this and other projects through [Patreon](https://patreon.com/theDrake/), but if it doesn't offer what you're looking for then we recommend checking out another tried-and-true Arch installer, such as [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases), [ArchLabs](https://archlabslinux.com/get/), or a pure [Arch Linux ISO](https://archlinux.org/download/). For a more beginner-friendly experience, we highly recommend such Arch-based distros as [Manjaro](https://manjaro.org/download/), [EndeavourOS](https://endeavouros.com/download/), and [Garuda Linux](https://garudalinux.org/downloads.html) as well as [Ubuntu](https://ubuntu.com/download/desktop) and Ubuntu-based distros like [Linux Mint](https://www.linuxmint.com/download.php) and [Pop!_OS](https://pop.system76.com/).

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other Linux-related contexts.)

## Features

### Desktop Environment (DE)

Four popular DEs, each lovingly customized for beauty and usability, are available during installation:

- [KDE Plasma](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/KDE-Plasma)

[![Screenshot of Golden Drake Linux with a customized KDE Plasma desktop environment](screenshots/gdl-kde-plasma-small.jpg)](screenshots/gdl-kde-plasma.jpg?raw=true)

- [GNOME](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/GNOME)

[![Screenshot of Golden Drake Linux with a customized GNOME desktop environment](screenshots/gdl-gnome-small.jpg)](screenshots/gdl-gnome.jpg?raw=true)

- [Cinnamon](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Cinnamon)

[![Screenshot of Golden Drake Linux with a customized Cinnamon desktop environment](screenshots/gdl-cinnamon-small.jpg)](screenshots/gdl-cinnamon.jpg?raw=true)

- [Xfce](https://github.com/GoldenDrakeStudios/golden-drake-linux/wiki/Xfce)

[![Screenshot of Golden Drake Linux with a customized Xfce desktop environment](screenshots/gdl-xfce-small.jpg)](screenshots/gdl-xfce.jpg?raw=true)

All DEs include a custom [`.bashrc`](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/extra/skel/.bashrc) file to provide the following while in a terminal:

- A `roll` function for tabletop gaming or anytime random numbers are desired: type `roll 3 6` to roll 3d6 (or just `roll 3` since six-sided dice is the default), `roll 2 4` to roll 2d4, `roll 1 20` to roll 1d20, etc.
- Functions for creating and extracting archive files: `maketarxz`, `maketargz`, `makezip`, and `extract`.
- An `mcd` function for creating a directory and immediately moving into it.
- Aliases to improve some basic commands, facilitate a few important tasks (`updatemirrors`, `updategrub`, `yaycleanup`, etc.), and provide more convenient access to features of some of the fun terminal programs listed below.

### Software

- AUR helper `yay` (`yay-bin`) for convenient access to [AUR software](https://aur.archlinux.org/packages/).
- [GameMode](https://github.com/FeralInteractive/gamemode) (inc. `lib32-gamemode`) for easy performance optimization via `gamemoderun [app]` (automatic for anything played through [Lutris](https://lutris.net/)).
- A wide selection of optional free/libre and open source ([FLOSS](https://www.gnu.org/philosophy/floss-and-foss.en.html)) games and gaming-related software ([OBS Studio](https://obsproject.com/), [MangoHud](https://github.com/flightlessmango/MangoHud), [Discord](https://discord.com/), etc.).
- If [Lutris](https://lutris.net/) is selected during installation, GDL will also include `wine-staging`, `winetricks`, and other useful packages for running Windows apps/games, including all the prerequisites for Lutris-assisted installation of [Blizzard Battle.net](https://lutris.net/games/battlenet/), providing access to *Overwatch*, *World of Warcraft*, *Hearthstone*, *Starcraft II*, *Diablo III*, etc., all within Linux!
- [Steam](https://store.steampowered.com/), [itch.io](https://itch.io/), the "[heroic](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher)" Epic Games launcher, [RetroArch](https://www.libretro.com/), etc., can also be selected to provide even more access to an endless variety of games.
- The [Godot](https://godotengine.org/) game engine, [Unreal Engine](https://www.unrealengine.com/), [Unity Hub](https://unity3d.com/get-unity/download), [Gimp](https://www.gimp.org/), [Inkscape](https://inkscape.org/), [Goxel](https://goxel.xyz/), [Blender](https://www.blender.org/), [Tiled](https://www.mapeditor.org/), [Audacity](https://www.audacityteam.org/), [LibreSprite](https://libresprite.github.io/), and other apps relevant to game art, game programming, and other aspects of game development are also optionally available.
- [LibreOffice](https://www.libreoffice.org/) for spreadsheets, word processing, presentations, etc., with dark theming applied (for light theming, go to *Tools > Options > Application Colors* and change the color scheme from "LibreOffice Dark" to "LibreOffice").
- [Audacious](https://audacious-media-player.org/) for music and either [VLC](https://www.videolan.org/vlc/) (KDE Plasma), [Totem](https://wiki.gnome.org/Apps/Videos) (GNOME), or [Celluloid](https://celluloid-player.github.io/)/[mpv](https://mpv.io/) (Cinnamon/Xfce) for videos along with [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/), [PipeWire](https://pipewire.org/), and all the [GStreamer](https://gstreamer.freedesktop.org/) multimedia plugins plus a [MIDI](https://wiki.archlinux.org/title/MIDI) soundfont to satisfy all your audio needs.
- A variety of fun terminal programs, including `asciiquarium`, `cmatrix`, `cbonsai`, `cowsay`, `lolcat`, `boxes`, `figlet`, `toilet`, and `nms` ("[No more secrets](https://github.com/bartobri/no-more-secrets)," to recreate the data decryption effect from the 1992 hacker movie [*Sneakers*](https://www.youtube.com/watch?v=F5bAa6gFvLs&t=35s)).
- Access to the [Arch Wiki](https://wiki.archlinux.org/), online or offline, both during and after installation, via `wiki-search [query]` (courtesy of [`arch-wiki-lite`](http://kmkeen.com/arch-wiki-lite/)).
- The [Transmission](https://transmissionbt.com/) BitTorrent client, complete with a Qt (KDE Plasma) or GTK (GNOME/Cinnamon/Xfce) GUI.
- The "[Uncomplicated Firewall](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall)" (`ufw`), preinstalled and enabled.

### Kernel

GDL utilizes the standard [Linux kernel](https://wiki.archlinux.org/index.php/Kernel). Yes, there are a few interesting [custom kernels](https://wiki.archlinux.org/index.php/Kernel#Unofficial_kernels), such as xanmod and tkg, that can in some cases provide slight improvements to gaming performance, RAM usage, etc., but they can also reduce stability and make upgrading less convenient, so, for now, GDL only installs the vanilla kernel. You are, of course, free to install additional kernels as you see fit.

### Language Support

You can select any locale/language for your new system, but as for the installer itself, GDL currently supports the following languages:

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

Options for Chinese (中文), Japanese (日本語), and Korean (한국어) fonts have been investigated, but the text-based environment of this type of installer doesn't support these and certain other languages. We may eventually shift to a different environment in order to support more languages.

## Minimum System Requirements

- CPU: 1 GHz dual-core 64-bit processor (3 GHz quad-core recommended)
- GPU: Whatever you need for the type of games you want to play/develop!
- Memory: 2 GB RAM (16 GB recommended)
- Storage: 20 GB of HDD/SSD space (1 TB recommended)

## Reporting Issues

If you encounter an issue that might just be a general hardware/software issue, or you simply have questions about terminology, processes, etc., first check the [Arch Wiki](https://wiki.archlinux.org/), [Arch Forums](https://bbs.archlinux.org/), [man pages](https://wiki.archlinux.org/title/Man_page), and other resources for relevant information. (Consider this a gentle reminder to [RTFM](https://en.wikipedia.org/wiki/RTFM)...ha!)

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

If you'd like to provide a new translation or modify an existing [language file](https://github.com/GoldenDrakeStudios/golden-drake-linux/tree/master/lang), that would be wonderful! Please use [english.conf](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/lang/english.conf) as your starting point.

## Compiling

GDL uses `git-lfs` to manage images, so if you want to use `git` to clone the GDL repository, first ensure `git-lfs` is installed on your system.

To compile within an Arch Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). That is the recommended method. However, if an Arch Linux environment isn't available, you can build within a container by adding `-c` or `--container` to the command (e.g., `sudo ./build.sh -c`).

Once the build is complete, the ISO file will be located in an `out` directory.

## License

This project is licensed under the [GNU GPLv2 license](LICENSE).
