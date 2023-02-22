#!/bin/bash

if [ $(id -u) = 0 ]; then
   echo "This script changes your users gsettings and should thus not be run as root!"
   echo "You may need to enter your password multiple times!"
   exit 1
fi


###
# Optionally clean all dnf temporary files
###

sudo dnf clean all

###
# RpmFusion Free Repo
# This is holding only open source, vetted applications - fedora just cant legally distribute them themselves thanks to 
# Software patents
###

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 

###
# RpmFusion NonFree Repo
# This includes Nvidia Drivers and more
###

sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


###
# Force update the whole system to the latest and greatest
###

sudo dnf upgrade --best --allowerasing --refresh -y

# And also remove any packages without a source backing them
sudo dnf distro-sync -y

###
# Install base packages and applications
###

sudo dnf install \
-y \
exfat-utils `#Allows managing exfat (android sd cards and co)` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
file-roller-nautilus `#More Archives supported in nautilus` \
fuse-exfat `#Allows mounting exfat` \
fuse-sshfs `#Allows mounting servers via sshfs` \
gimp `#The Image Editing Powerhouse - and its plugins` \
gnome-shell-extension-dash-to-dock `#dash for gnome` \
gnome-shell-extension-user-theme `#Enables theming the gnome shell` \
gnome-tweaks `#Your central place to make gnome like you want` \
gnome-extensions-app
gtkhash-nautilus `#To get a file has via gui` \
inkscape  `#Working with .svg files` \
krita  `#Painting done right` \
lm_sensors `#Show your systems Temparature` \
'mozilla-fira-*' `#A nice font family` \
papirus-icon-theme `#A quite nice icon theme` \
gnome-shell-extension-dash-to-panel
vlc
p7zip
p7zip-plugins
unzip
unrar
gparted
gimp
kdenlive
flameshot
deja-dup
webp-pixbuf-loader
la-capitaine-cursor-theme
cmake
gettext
nemo
nemo-preview
nemo-fileroller
nemo-emblems

###
# Remove some un-needed stuff
###

sudo dnf remove \
-y \
gnome-shell-extension-background-logo `#Tasteful but nah` \


###
# Theming and GNOME Options
###


#Gnome Shell Theming
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Snow'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark-solid'

#Set SCP as Monospace (Code) Font
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro Semi-Bold 12'

#Set Extensions for gnome
gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com']"

#Better Font Smoothing
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

#Usability Improvements
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'adaptive'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

#Dash to Dock Theme
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#729fcf'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'SEGMENTED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.70000000000000000
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

#This indexer is nice, but can be detrimental for laptop users battery life
gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery false
gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery-first-time false
gsettings set org.freedesktop.Tracker.Miner.Files throttle 15

#Nautilus (File Manager) Usability
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.list-view use-tree-view trueC

#Gnome Night Light (Like flux/redshift)
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 9.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 18.0

# Basic Music Example Tweaks
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer post-messages true
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer state true
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer amount 4.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer harmonics 10.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer scope 75.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer floor 10.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer blend -10.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.bassenhancer input-gain -3.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools post-messages true
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools state true
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools sc-level 1.0
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools delay 0.10000000000000000
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools stereo-base 0.10000000000000000
gsettings set com.github.wwmm.pulseeffects.sinkinputs.stereotools stereo-phase 0.10000000000000000


# Steam games (32bit) have issues with the too new 32bit compat libs in fedora
# Flatpak is the better option here
if [ ! -z "$STEAMFLAT" ]; then
	sudo dnf install -y flatpak
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user flathub com.valvesoftware.Steam

    flatpak remote-add --if-not-exists --user freedesktop-sdk https://cache.sdk.freedesktop.org/freedesktop-sdk.flatpakrepo

    # Mesa-ACO makes steam render WAY better under amd cards.
    flatpak install --user freedesktop-sdk \
        org.freedesktop.Platform.GL.mesa-aco//19.08 \
        org.freedesktop.Platform.GL32.mesa-aco//19.08

    flatpak update --user

    #To run it with mesa-aco:
    #FLATPAK_GL_DRIVERS=mesa-aco flatpak run com.valvesoftware.Steam
	# Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam
fi

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
