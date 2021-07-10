<p align="center"><img src="banner.svg" title="Golden Drake"></p>

# About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is an [Arch Linux](https://www.archlinux.org/) installer designed for gamers and game developers. GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution): it's simply a convenient method for installing a customized version of the Arch distro and thus only utilizes the standard Arch repositories along with the [Arch User Repository (AUR)](https://aur.archlinux.org/). GDL is based primarily on the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer/) with additional inspiration from [archdi-pkg](https://github.com/MatMoul/archdi-pkg), [ArchLabs](https://bitbucket.org/archlabslinux/installer/src/master/), and [Manjaro](https://gitlab.manjaro.org/profiles-and-settings). The installer ISO is built using [Archiso](https://wiki.archlinux.org/index.php/Archiso) and the installation process uses [dialog](https://en.wikipedia.org/wiki/Dialog_(software)) for a visually appealing TUI (text-based UI, a.k.a., terminal UI).

GDL is a side project of indie game development studio [Golden Drake Studios (GDS)](https://goldendrakestudios.com/), with updates and support provided by GDS's founder, [David C. Drake](https://davidcdrake.com/). We hope you'll enjoy it, provide constructive feedback, and support our ongoing work on this and other projects through [Patreon](https://patreon.com/theDrake/), but if it doesn't offer what you're looking for then we recommend checking out another tried-and-true Arch installer, such as [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases), [ArchLabs](https://archlabslinux.com/get/), or a pure [Arch Linux ISO](https://archlinux.org/download/). For a more beginner-friendly experience, we highly recommend such Arch-based distros as [Manjaro](https://manjaro.org/download/), [EndeavourOS](https://endeavouros.com/download/), and [Garuda Linux](https://garudalinux.org/downloads.html) as well as [Ubuntu](https://ubuntu.com/download/desktop) and Ubuntu-based distros like [Linux Mint](https://www.linuxmint.com/download.php) and [Pop!_OS](https://pop.system76.com/).

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other Linux-related contexts.)

# Features

- AUR helper `yay` (`yay-bin`) preinstalled for convenient access to AUR software.
- A wide selection of free/libre and open source ([FLOSS](https://www.gnu.org/philosophy/floss-and-foss.en.html)) games and gaming-related software (OBS Studio, MangoHud, Discord, etc.) available during installation.
- If Lutris is selected during installation, GDL will also include `wine-staging`, `winetricks`, and other useful packages for running Windows apps/games, including all the prerequisites for Lutris-assisted installation of [Blizzard Battle.net](https://lutris.net/games/battlenet/), providing access to *Overwatch*, *World of Warcraft*, *Hearthstone*, *Starcraft II*, *Diablo III*, etc., all within Linux!
- Steam, itch.io, the "legendary" Epic Games launcher, RetroArch, etc., can also be selected to provide even more access to an endless variety of games.
- Unity Hub, Unreal Engine, Godot game engine, Gimp, Inkscape, Goxel, Blender, Tiled, Audacity, LibreSprite, and other apps relevant to game art, game programming, and other aspects of game development available for optional preinstallation.
- A fast, stable, lightweight, and versatile desktop environment, [Xfce](https://www.xfce.org/), beautifully customized as follows:
  - Thanks to `[xfce-superkey-git](https://aur.archlinux.org/packages/xfce-superkey-git/)`, the Super key (a.k.a., Windows key) opens the Whisker Menu *without any undesirable side effects*. In addition, several keyboard shortcuts have been set up to use the Super key, including:
    - Super+Up: Maximize window.
    - Super+Down: Minimize window.
    - Super+Right/Left: Tile window to the right/left (Super can also be used with numpad keys for tiling to the corners and top/bottom of the screen).
    - Super+D: Show desktop.
    - Super+W: Launch default **w**eb browser.
    - Super+T: Launch default **t**erminal.
    - Shift+Super+T: Launch a fun alternative **t**erminal (`cool-retro-term`).
    - Super+C: Launch **c**alculator (`galculator`).
    - Shift+Super+C: Launch GNOME **c**haracter map for convenient access to emojis and other special characters (`gnome-characters`).
    - Super+E: Launch text **e**ditor (`mousepad`).
    - Super+F: Launch **f**ile manager (`thunar`).
    - Super+S: Launch **s**ettings manager (`xfce4-settings-manager`).
    - Super+K: **K**ill selected window (`xkill`).
    - Super+L: **L**ock screen (`xflock4`).
  - To avoid annoyance, the standard "alert bell/beep" is disabled and the behavior of highlighting text by holding the Shift key while using numpad keys is adjusted to suit most modern users’ expectations. These settings occur at login courtesy of the `[.xprofile](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/extra/skel/.xprofile)` file, which can be modified if desired. Settings for [IBus keyboard input](https://wiki.archlinux.org/title/IBus) are also added to `.xprofile` if any IBus software is selected during installation (e.g., for typing in Chinese, Japanese, or Korean).
  - The default terminal emulator has been set to `[terminator](https://wiki.archlinux.org/title/Terminator)` to take advantage of its ability to split the terminal vertically (Ctrl+Shift+E) and horizontally (Ctrl+Shift+O). The Xfce terminal is still available as a backup and, of course, you can easily replace `terminator` with your own favorite terminal.
  - Visually, the environment is set up with a nice dark theme, a tasteful touch of red and gold here and there, and subtle window compositing effects, all of which can, like all settings and customizations, be changed to suit your personal taste and preferences.
  - If a game exhibits screen-tearing or other issues that might be caused by the window compositor, disable/enable compositing via this keyboard shortcut (chosen to match KDE Plasma and to avoid anything likely to be typed by accident): Alt+Shift+F12.
- [LibreOffice](https://www.libreoffice.org/) for spreadsheets, word processing, presentations, etc., and [Atril](https://github.com/mate-desktop/atril) for viewing PDFs, comic books, and various other documents.
- [Audacious](https://audacious-media-player.org/) for listening to music and [Celluloid](https://celluloid-player.github.io/) ([mpv](https://mpv.io/)) for watching videos, with [Parole](https://docs.xfce.org/apps/parole/introduction) as a backup media player. [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) and [PipeWire](https://pipewire.org/) are preinstalled along with all the [GStreamer](https://gstreamer.freedesktop.org/) multimedia plugins plus a soundfont for playing [MIDI](https://wiki.archlinux.org/title/MIDI) files.
- The `[gcolor2](http://gcolor2.sourceforge.net/)` app for selecting on-screen colors.
- A variety of fun terminal programs, including `asciiquarium`, `cmatrix`, `cbonsai`, `cowsay`, `lolcat`, `boxes`, `figlet`, `toilet`, and `nms` ("[No more secrets](https://github.com/bartobri/no-more-secrets)," to recreate the data decryption effect from the 1992 hacker movie [*Sneakers*](https://www.youtube.com/watch?v=F5bAa6gFvLs&t=35s)).
- A custom `[.bashrc](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/extra/skel/.bashrc)` file to provide the following while in a terminal:
  - A `roll` function for tabletop gaming or anytime random numbers are desired: type "`roll 3 6`" to roll 3d6 (or just "`roll 3`" since six-sided dice is the default), "`roll 2 4`" to roll 2d4, "`roll 1 20`" to roll 1d20, etc.
  - Functions for creating and extracting archive files: `maketar`, `makezip`, and `extract`.
  - An `mcd` function for creating a directory and immediately moving into it.
  - Aliases to improve some basic commands, facilitate a few important tasks (`yayupdate`, `yaycleanup`, etc.), and provide more convenient access to features of some of the fun terminal commands listed above.
- Access to the Arch Wiki, online or offline, during and after installation, via "`wiki-search [query]`" (courtesy of `[arch-wiki-lite](http://kmkeen.com/arch-wiki-lite/)`).
- The "[Uncomplicated Firewall](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall)" (`ufw`), preinstalled and enabled.
- Xorg display server (might shift to Wayland eventually).
- The standard Linux kernel. Yes, there are a few interesting custom kernels, such as xanmod and tkg, that can in some cases provide slight improvements to gaming performance, RAM usage, etc., but they can also reduce stability and make upgrading less convenient, so, for now, GDL only installs the vanilla kernel. You are, of course, free to install additional kernels on your own.

# Minimum System Requirements

- CPU: 1 GHz dual-core 64-bit processor (3 GHz quad-core recommended)
- GPU: whatever you need for the type of games you want to play/develop!
- Memory: 2 GB RAM (16 GB recommended)
- Storage: 20 GB of HDD/SSD space (1 TB recommended)

# Reporting Issues

If you encounter an issue that might just be a general hardware/software issue, or you simply have questions about terminology, processes, etc., first check the [Arch Wiki](https://wiki.archlinux.org/), [Arch Forums](https://bbs.archlinux.org/), and other online resources for relevant information.

If you're highly confident an issue you've encountered is due to a problem within GDL, please provide a detailed report via [GitHub](https://github.com/GoldenDrakeStudios/golden-drake-linux/issues) or email (support[at]goldendrakestudios[dot]com) and, if convenient, share the installation log located at `/root/gdl.log` either as a direct attachment or by running the command `nc termbin.com 9999 < /root/gdl.log` in the terminal and sharing the returned URL.

# Contributing

Please feel free to send suggestions, questions, feature requests, etc., to the project maintainer, David C. Drake: drake[at]goldendrakestudios[dot]com

To contribute financially and receive certain benefits, including increased influence over the development of GDL as well as our indie game projects, please support us through [Patreon](https://patreon.com/theDrake/).

If you wish to modify or supplement the project's code, feel free to submit a pull request. Please adhere to the following guidelines:

- Follow shell scripting best practices, such as those recommended in [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- Use `"${variable}"` instead of `$variable` (but omit the quotation marks when necessary, i.e., in rare cases when a variable needs to be word-split into multiple strings).
- Constants and global variables should be named `LIKE_THIS`, other variables (and functions) `like_this`.
- Write comments where needed.
- Use `shellcheck` and thoroughly test your code.
- Write informative commit messages.

If you'd like to provide a new translation or modify an existing [language file](https://github.com/GoldenDrakeStudios/golden-drake-linux/tree/master/lang), that would be greatly appreciated! Please use [english.conf](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/lang/english.conf) as your starting point.

# Compiling

GDL uses `git-lfs` to manage images, so if you want to use `git` to clone the GDL repository, first ensure `git-lfs` is installed on your system.

To compile within an Arch Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). That is the recommended method. However, if an Arch Linux environment isn't available, you can build within a container by adding `-c` or `--container` to the command (e.g., `sudo ./build.sh -c`).

Once the build is complete, the ISO file will be located in an `out` directory.

# License

This project is licensed under the [GNU GPLv2 license](LICENSE).
