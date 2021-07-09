<p align="center"><img src="banner.svg" title="Golden Drake"></p>

# About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is an [Arch Linux](https://www.archlinux.org/) installer designed for gamers and game developers. GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution): it's simply a convenient method for installing a customized version of the Arch distro and thus only utilizes the standard Arch repositories along with the [Arch User Repository (AUR)](https://aur.archlinux.org/). GDL is based primarily on the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer/) with additional inspiration from [archdi-pkg](https://github.com/MatMoul/archdi-pkg), [ArchLabs](https://bitbucket.org/archlabslinux/installer/src/master/), and [Manjaro](https://gitlab.manjaro.org/profiles-and-settings). The installer ISO is built using [Archiso](https://wiki.archlinux.org/index.php/Archiso) and the installation process uses [dialog](https://en.wikipedia.org/wiki/Dialog_(software)) for a visually appealing TUI (text-based UI, a.k.a., terminal UI).

GDL is a side project of indie game development studio [Golden Drake Studios (GDS)](https://goldendrakestudios.com/), with updates and support provided by GDS's founder, [David C. Drake](https://davidcdrake.com/). We hope you'll enjoy it, provide constructive feedback, and support our ongoing work on this and other projects through [Patreon](https://patreon.com/theDrake/), but if it doesn't offer what you're looking for then we recommend checking out another tried-and-true Arch installer, such as [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases), [ArchLabs](https://archlabslinux.com/get/), or a pure [Arch Linux ISO](https://archlinux.org/download/). For a more beginner-friendly experience, we highly recommend such Arch-based distros as [Manjaro](https://manjaro.org/download/), [EndeavourOS](https://endeavouros.com/download/), and [Garuda Linux](https://garudalinux.org/downloads.html) as well as [Ubuntu](https://ubuntu.com/download/desktop) and Ubuntu-based distros like [Linux Mint](https://www.linuxmint.com/download.php) and [Pop!_OS](https://pop.system76.com/).

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other Linux-related contexts.)

# Compiling

GDL uses `git-lfs` to manage images, so if you wish to use `git` to clone the GDL repository, first ensure `git-lfs` is installed on your system.

To compile within an Arch Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). Otherwise, there are two options for building within a container:

- Run `build.sh -c` to build via `podman`.
- Manually build using the `Containerfile` with your own custom arguments.

Once the build is complete, the ISO file will be located in the `out` directory.

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

If you want to provide a new translation or modify an existing language file in [src/usr/share/gdl/lang/](https://github.com/GoldenDrakeStudios/golden-drake-linux/tree/master/lang), that would be greatly appreciated! Please use [english.conf](https://github.com/GoldenDrakeStudios/golden-drake-linux/blob/master/lang/english.conf) as your starting point.

# License

This project is licensed under the [GNU GPLv2 license](LICENSE).
