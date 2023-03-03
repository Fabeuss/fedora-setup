#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Fedora Setup Util - Original By Osiris"
TITLE="Please Make a selection"
MENU="Please Choose one of the following options:"

#Check to see if Dialog is installed, if not install it - Thanks Kinkz_nl
if [ $(rpm -q dialog 2>/dev/null | grep -c "is not installed") -eq 1 ]; then
sudo dnf install -y dialog
fi

OPTIONS=(1 "Enable RPM Fusion - Enables the RPM Fusion repos for your specific version"
         2 "Update Firmware - If your system supports fw update delivery"
         3 "Speed up DNF - This enables fastestmirror and max downloads"
         4 "Enable Flatpak - Enables the Flatpak repo and installs packages"
         5 "Install Software - Installs a bunch of my most used software"
         6 "Install Waydroid"
         7 "Install Librewolf"
         8 "Install Extras - Fonts"
	 9 "Install media Codecs"
	 10 "Gnome tweaks"
	 11 "Quit")

while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

    clear
    case $CHOICE in
        1)  echo "Enabling RPM Fusion"
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	    sudo dnf upgrade --refresh
            sudo dnf groupupdate -y core
            sudo dnf install -y rpmfusion-free-release-tainted
	    sudo dnf install -y rpmfusion-nonfree-release-tainted
            sudo dnf install -y dnf-plugins-core; exec $SHELL;
            notify-send "RPM Fusion Enabled" --expire-time=10
           ;;
        2)  echo "Updating Firmware"
            sudo fwupdmgr get-devices 
            sudo fwupdmgr refresh --force 
            sudo fwupdmgr get-updates 
            sudo fwupdmgr update; exec $SHELL;
           ;;
        3)  echo "Speeding Up DNF"
            echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf; exec $SHELL;
            notify-send "Speeding Up DNF completed" --expire-time=10
           ;;
        4)  echo "Enabling Flatpak"
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak update
            source 'flatpak-install.sh'; exec $SHELL;
            notify-send "Flatpak has now been enabled" --expire-time=10
           ;;
        5)  echo "Installing Software"
            sudo dnf install -y $(cat dnf-packages.txt); exec $SHELL;
            notify-send "Software has been installed" --expire-time=10
           ;;
        6)  echo "Installing Waydroid"
            sudo dnf copr enable aleasto/waydroid -y
	    sudo dnf update -y
            sudo dnf install waydroid
	    sudo systemctl enable --now waydroid-container; exec $SHELL;
            notify-send "Waydroid has been installed" --expire-time=10
           ;;
        7)  echo "Installing Librewolf"
            sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo -y
	    sudo dnf update -y
	    sudo dnf install librewolf; exec $SHELL;
            notify-send "Librewolf has been installed" --expire-time=10
           ;;
        8)  echo "Installing Extra Fonts"
            sudo dnf copr enable peterwu/iosevka -y
            sudo -s dnf -y copr enable dawid/better_fonts
            sudo dnf update -y
            sudo -s dnf install -y fontconfig-font-replacements
            sudo -s dnf install -y fontconfig-enhanced-defaults
	    sudo dnf update -y
	    sudo dnf install -y iosevka-term-fonts jetbrains-mono-fonts-all terminus-fonts terminus-fonts-console google-roboto google-noto-fonts-common mscore-fonts-all fira-code-fonts; exec $SHELL;
            notify-send "All done" --expire-time=10
           ;;
        9)  echo "Installing media codecs"
            sudo dnf groupupdate -y sound-and-video
            sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
            sudo dnf install -y lame\* --exclude=lame-devel
            sudo dnf group upgrade -y --with-optional Multimedia; exec $SHELL;
           ;;
	10)  echo "Tweaking Gnome Shell"
            source 'gsettings.sh'; exec $SHELL;
            notify-send "Gnome Shell has now been tweaked" --expire-time=10
           ;;
	11)
          exit 0
          ;;
    esac
done
