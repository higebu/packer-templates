#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Clean up
sudo unlink /usr/src/linux
sudo unlink /lib/modules/$(uname -r)/build
sudo aptitude -y remove linux-vyatta-kbuild build-essential
sudo apt-get autoclean
sudo apt-get clean

# Delete Debian squeeze package repository and temporary mirror
delete system package repository community
delete system package repository squeeze
delete system package repository squeeze-lts
set system package repository community components 'main'
set system package repository community distribution 'helium'
set system package repository community url 'http://packages.vyos.net/vyos'
commit
save
