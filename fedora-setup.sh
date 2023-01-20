#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Fedora Setup Util - By Osiris - https://lsass.co.uk"
TITLE="Please Make a selection"
MENU="Please Choose one of the following options:"

#Check to see if Dialog is installed, if not install it - Thanks Kinkz_nl
if [ $(rpm -q dialog 2>/dev/null | grep -c "is not installed") -eq 1 ]; then
sudo dnf install -y dialog
fi

OPTIONS=(1 "Enable RPM Fusion - Enables the RPM Fusion repos for your specific version"
         2 "Update Firmware - If your system supports fw update delivery"
         3 "Speed up DNF - This enables fastestmirror, max downloads and deltarpms"
         4 "Enable Flatpak - Enables the Flatpak repo and installs packages"
         5 "Install Software - Installs a bunch of my most used software"
         6 "Install Waydroid"
         7 "Install flat-remix themes"
         8 "Install Extras - Fonts"
	 9 "Quit")

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
            sudo dnf install -y dnf-plugins-core
            notify-send "RPM Fusion Enabled" --expire-time=10
           ;;
        2)  echo "Updating Firmware"
            sudo fwupdmgr get-devices 
            sudo fwupdmgr refresh --force 
            sudo fwupdmgr get-updates 
            sudo fwupdmgr update
           ;;
        3)  echo "Speeding Up DNF"
            echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
            echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
            notify-send "Your DNF config has now been amended" --expire-time=10
           ;;
        4)  echo "Enabling Flatpak"
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak update
            source 'flatpak-install.sh'
            notify-send "Flatpak has now been enabled" --expire-time=10
           ;;
        5)  echo "Installing Software"
            sudo dnf install -y $(cat dnf-packages.txt)
            notify-send "Software has been installed" --expire-time=10
           ;;
        6)  echo "Installing Waydroid"
            sudo dnf copr enable aleasto/waydroid -y
	    sudo dnf update -y
            sudo dnf install waydroid
	    sudo systemctl enable --now waydroid-container
            notify-send "Waydroid has been installed" --expire-time=10
           ;;
        7)  echo "Installing flat-remix"
            sudo dnf install -y gnome-shell-theme-flat-remix flat-remix-icon-theme flat-remix-theme
            notify-send "Flat-remix has been installed" --expire-time=10
           ;;
        8)  echo "Installing Extra Fonts"
            sudo dnf copr enable peterwu/iosevka -y
            sudo -s dnf -y copr enable dawid/better_fonts
            sudo dnf update -y
            sudo -s dnf install -y fontconfig-font-replacements
            sudo -s dnf install -y fontconfig-enhanced-defaults
	    sudo dnf update -y
	    sudo dnf install -y iosevka-term-fonts jetbrains-mono-fonts-all terminus-fonts terminus-fonts-console google-roboto google-noto-fonts-common mscore-fonts-all fira-code-fonts
            notify-send "All done" --expire-time=10
           ;;
        9)
          exit 0
          ;;
    esac
done
