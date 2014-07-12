#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Add Debian squeeze package repository and temporary mirror
delete system package repository community
set system package repository community components 'main'
set system package repository community distribution 'hydrogen'
set system package repository community url 'http://mirror.vyos-users.jp/vyos'
set system package repository squeeze url http://ftp.jp.debian.org/debian/
set system package repository squeeze distribution squeeze
set system package repository squeeze components 'main contrib non-free'
set system package repository squeeze-lts url http://ftp.jp.debian.org/debian/
set system package repository squeeze-lts distribution squeeze
set system package repository squeeze-lts components 'main contrib non-free'
commit
save

sudo apt-get -y update

# Install build-essential and linux-vyatta-kbuild
sudo apt-get -y install build-essential
sudo apt-get -y install linux-vyatta-kbuild
sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyatta/ /usr/src/linux
sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyatta/ /lib/modules/$(uname -r)/build

# Tweak sshd to prevent DNS resolution (speed up logins)
configure
set service ssh disable-host-validation
commit
save

# Disable except tty1
sudo sed -i 's/ACTIVE_CONSOLES=\"\/dev\/tty\[1-6\]\"/ACTIVE_CONSOLES=\"\/dev\/tty1\"/' /etc/default/console-setup
sudo sed -i -e 's,^.*:/sbin/getty\s\+.*\s\+tty[2-6],#\0,' /etc/inittab

# Remove 5s grub timeout to speed up booting
cat <<EOF | sudo tee /usr/share/grub/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""
EOF

sudo update-grub
