#!/usr/bin/bash

echo "Update System"
apt-get update && apt-get upgrade -y


echo "Install/Update needed Packages1"
sudo apt-get install fbi vorbis-tools mpv insserv avahi-daemon -y

echo "Install/Update needed Packages2"
sudo apt-get install libboost-dev libusb-1.0-0-dev libudev-dev libx11-dev scons pkg-config python3 x11proto-core-dev libdbus-glib-1-dev -y


echo "Change to RetroPie-Setup-Folder"


mv "/home/pi/RetroPie-Setup/.git/config" "/home/pi/RetroPie-Setup/.git/config_backup"
    cat > "/home/pi/RetroPie-Setup/.git/config" << _EOF_
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://github.com/microplay-hub/RetroPie-NXT
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
_EOF_

    chown $user:$user "/home/pi/RetroPie-Setup/.git/config"
	chmod 755 "/home/pi/RetroPie-Setup/.git/config"

echo "Update git Source"
cd /home/pi/RetroPie-Setup/
git remote set-branches origin '*'

git pull

git checkout master

rm -rf "/home/pi/RetroPie-Setup/ext"

>/etc/dhcp/dhclient-enter-hooks.d/unset_old_hostname

su pi

sudo /home/pi/RetroPie-Setup/retropie_setup.sh