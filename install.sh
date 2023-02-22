#!/bin/bash

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
gimp
gnome-shell-extension-dash-to-dock
gnome-shell-extension-user-theme
gnome-tweaks
gnome-extensions-app
gtkhash-nautilus
inkscape
krita
lm_sensors `#Show your systems Temparature` \
'mozilla-fira-*'
'google-roboto*'
fira-code-fonts
papirus-icon-theme
gnome-shell-extension-dash-to-panel
vlc
p7zip
p7zip-plugins
unzip
unrar
gparted
gimp
kdenlive
deja-dup
webp-pixbuf-loader
la-capitaine-cursor-theme
cmake
gettext
nemo
nemo-preview
nemo-fileroller
nemo-emblems
fish
util-linux-user
powerline-fonts

###
# Remove some un-needed stuff
###

sudo dnf remove \
-y \
gnome-shell-extension-background-logo `#Tasteful but nah` \


###
# Theming and GNOME Options
###


#Better Font Smoothing
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

#Usability Improvements
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'adaptive'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

#Nautilus (File Manager) Usability
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

#Gnome Night Light (Like flux/redshift)
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 7.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 18.0

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
