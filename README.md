<p align="center"><img src="assets/banner.svg" title="Golden Drake"></p>

# About

[Golden Drake Linux (GDL)](https://goldendrakestudios.com/golden-drake-linux/) is a simple [Arch Linux](https://www.archlinux.org/) installer designed for gamers and game developers. Like the [Anarchy installer](https://gitlab.com/anarchyinstaller/installer/) it's based on, GDL is not an independent [distro](https://en.wikipedia.org/wiki/Linux_distribution). Rather, it's simply a convenient method for installing a customized version of the Arch distro and will guide you along each step of the installation process, from partitioning your disk(s) to installing your desired software.

Ultimately, GDL is just a fun "side project" with limited updates and support provided by [Golden Drake Studios](https://goldendrakestudios.com/). We hope you'll enjoy it and provide constructive feedback, but if it doesn't offer what you're looking for, we recommend checking out the latest release of [Anarchy](https://gitlab.com/anarchyinstaller/installer/-/releases) or, for a more user-friendly Arch-based experience, [Manjaro](https://manjaro.org/download/) or [EndeavourOS](https://endeavouros.com/download/). Alternatively, we can also highly recommend [Ubuntu](https://ubuntu.com/download/desktop) and Ubuntu-based distros like [Linux Mint](https://www.linuxmint.com/download.php), options that some people consider even more user-friendly and beginner-friendly.

(Please note that the acronym "GDL" can also refer to the [GNOME Docking Library](https://gitlab.gnome.org/GNOME/gdl) in other Linux-related contexts.)

# Compiling

GDL uses `git-lfs` to manage images, so if you wish to use `git` to clone the GDL repository, first ensure `git-lfs` is installed on your system.

To compile within an Arch Linux environment, run `build.sh` with root permissions (e.g., `sudo ./build.sh`). Otherwise, there are two options for building within a container:

- Run `build.sh -c` to build via `podman`.
- Manually build using the `Containerfile` with your own custom arguments.

Once the build is complete, the ISO file will be located in the `out` directory.

# Reporting Issues

If you encounter an issue that might just be a general hardware/software issue, or you simply have questions about terminology, processes, etc., first check the [Arch Wiki](https://wiki.archlinux.org/), [Arch Forums](https://bbs.archlinux.org/), and other online resources for relevant information.

If you're highly confident an issue you've encountered is due to a problem within GDL, please provide a detailed report via [GitHub](https://github.com/GoldenDrakeStudios/golden-drake-linux/issues) or email (support[at]goldendrakestudios[dot]com) and, if the issue occurred during installation, run the command `cat /root/gdl.log | nc termbin.com 9999` in the terminal and share the returned URL as part of your report (this URL might be retrieved for you automatically if GDL recognizes that the installation failed).

# Contributing

Please feel free to send suggestions, questions, feature requests, etc., to the project maintainer, David C. Drake: drake[at]goldendrakestudios[dot]com

If you wish to modify or add to the project's shell scripts, feel free to submit a pull request. Please adhere to the following guidelines:

- Follow shell scripting best practices, such as in [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- Use `"${variable}"` instead of `$variable`.
- Constants and global variables should be in `UPPER_CASE`, other variables in `lower_case`.
- Write comments where needed (e.g., explaining functions).
- Executable scripts should be named `setup-<function>` (no `.sh` extension).
- Library scripts should have a `.sh` extension and should not be executable.
- Use `shellcheck` and also thoroughly test your code to check for errors.
- Write informative commit messages.

If you wish to provide a new translation or modify an existing language file in `src/usr/share/gdl/lang/`, use `english.conf` as your main reference point and adhere to the guidelines at the top of that file.

In some cases, it might make more sense to contribute to the upstream Anarchy project rather than GDL. If so, please refer to [Anarchy's Contributing Guide](https://gitlab.com/anarchyinstaller/installer/-/blob/master/CONTRIBUTING.md) and rest assured that your improvements to Anarchy will likely end up being incorporated into GDL as well.

# License

This project is licensed under the [GNU GPLv2 license](LICENSE).
