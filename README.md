# Fedora-Setup a Post Install Helper Script / credits to [osiris2600](https://github.com/osiris2600/fedora-setup)

## What's all this then?

Fedora-Setup is a personal script I created to help with post install tasks such as tweaks and software installs. It's written in Bash and utilises Dialog for a friendlier menu system.

Dialog must be installed for the menu system to work and as such the script will check to see if Dialog is installed. If not, it will ask you to install it.

## Usage
1. Set the script to be executable `chmod -x fedora-setup.sh` \
2. Run the script `./fedora-setup.sh`

## Files

- **flatpak-packages.txt** - This file contains a list of all flat packages to install you can customise this with your choice of applications by application-id.
- **dnf-packages.txt** - This file contains a list of all applications that will be installed via the Fedora and RPMFusion repositories.




## Screenshot

![Screenshot](fedora-setup-screenshot.png)

# Options

- ## Enable RPM Fusion
  - Enables RPM Fusion repositories using the official method from the RPM Fusion website. - [RPM Fusion](https://rpmfusion.org)
  > RPM Fusion provides software that the Fedora Project or Red Hat doesn't want to ship. That software is provided as precompiled RPMs for all current Fedora versions and current Red Hat Enterprise Linux or clones versions; you can use the RPM Fusion repositories with tools like yum and PackageKit.
- ## Update Firmware
  - **Updates firmware providing you have hardware that supports it.**
- ## Speed up DNF
  - **Enables fastest mirror**
  - **Sets max parallel downloads to 10**
  - **Enables DeltaRPMs**
- ## Enable Flatpak and Packages
  ### Adds the flatpak repo, updates and installs the following packages (or what you ahve specified in flatpak-packages.txt)
  - **Obfuscate** - [Censor private information](https://flathub.org/apps/details/com.belmoussaoui.Obfuscate)
  - **Signal Desktop** - [A cross platform secure messaging service](https://signal.org/en/download/)
  - **VideoTrimmer** - [Trim videos quickly](https://flathub.org/apps/details/org.gnome.gitlab.YaLTeR.VideoTrimmer)
  - **Extension Manager** - [Browse, install, and manage GNOME Shell Extensions](https://flathub.org/apps/details/com.mattjakeman.ExtensionManager)
  - **Flatseal** - [Manage Flatpak permissions](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
  - **ungoogled-chromium** - [A lightweight approach to removing Google web service dependency](https://flathub.org/apps/details/com.github.Eloston.UngoogledChromium)
- ## Install Software
  ### Installs the following pieces of software (or the applications you specify in dnf-packages.txt)
    - **btop** - [CLI based system monitor](https://github.com/aristocratos/btop)
    - **discord** - [The popular VoIP, IM and Social platform](https://discord.com)
    - **gnome-extensions-app** - Gnome extension management application
    - **gnome-tweaks** - Gnome shell tweak tool
    - **vlc**  - [A cross platform multimedia player](https://www.videolan.org/)
    - **p7zip** - [High compression archiving application](https://p7zip.sourceforge.net/)
    - **blender** - [FOSS 3d creation suite](https://www.blender.org/)
    - **gimp** - [GNU Image Manipulation Program](https://gimp.org)
    - **digikam** - [Professional photo management application](https://www.digikam.org/)
    - **kdenlive** - [FOSS cross platform video editing application](https://kdenlive.org/en/)
    - **transmission** - [A fast simple and free Bittorrent client](https://transmissionbt.com/)
    - **flameshot** - [FOSS screenshot software](https://flameshot.org/)
    - **persepolis** - [A fast download manager similar to Internet Download Manager for Windows](https://persepolisdm.github.io/)
    - **deja-dup** - [Easy to use backup tool from the GNOME project](https://wiki.gnome.org/Apps/DejaDup)
    - **webp-pixbuf-loader** - [webp support for Nautilus](https://github.com/aruiz/webp-pixbuf-loader/)
    - **la-capitaine-cursor-theme** - [This is an x-cursor theme inspired by macOS and based on KDE Breeze](https://github.com/keeferrourke/capitaine-cursors/)
- ## Install Waydroid
  - **Installs Waydroid** - [A container-based approach to boot a full Android system](https://waydro.id/)
- ## Install Extras
  ### Installs the following theme
    - **gnome-shell-theme-flat-remix** - [Flat Remix Gnome Theme](https://drasite.com/flat-remix-gnome)
    - **flat-remix-theme** - [Flat Remix GTK Theme](https://drasite.com/flat-remix-gtk)
    - **flat-remix-icon-theme** - [Flate Remix Icon Theme](https://drasite.com/flat-remix)
  ### Along with the following fonts
    - **iosevka-term-fonts** - [Iosevka Font](https://github.com/be5invis/Iosevka)
    - **jetbrains-mono-fonts-all** - [JetBrains Font](https://www.jetbrains.com/lp/mono/)
    - **terminus-fonts** - [Terminus Font](https://terminus-font.sourceforge.net/)
    - **terminus-fonts-console** - [Terminus Font](https://terminus-font.sourceforge.net/)
    - **google-noto-fonts-common** - [Google Noto Sans Font](https://fonts.google.com/noto/specimen/Noto+Sans)
    - **mscore-fonts-all**
    - **fira-code-fonts** - [Google Fira Code Font](https://fonts.google.com/specimen/Fira+Code)
    - **better fonts by dawid** - [Dawid's COPR](https://copr.fedorainfracloud.org/coprs/dawid/better_fonts/)
  ### Installs the following extras
    - **Sound and video group**
    - **gstreamer plugins**
