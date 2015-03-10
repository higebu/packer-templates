#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

if test -f VBoxGuestAdditions.iso ; then

  # Add Debian Squeeze Repository
  set system package repository squeeze url 'http://ftp.jp.debian.org/debian/'
  set system package repository squeeze distribution 'squeeze'
  set system package repository squeeze components 'main contrib non-free'
  set system package repository squeeze-lts url 'http://ftp.jp.debian.org/debian/'
  set system package repository squeeze-lts distribution 'squeeze-lts'
  set system package repository squeeze-lts components 'main contrib non-free'
  commit
  save

  sudo apt-get -y update
  
  # Install build-essential and linux-vyatta-kbuild
  sudo apt-get -y install build-essential
  sudo apt-get -y install linux-vyatta-kbuild
  sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyos/ /usr/src/linux
  sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyos/ /lib/modules/$(uname -r)/build

  # Install dkms for dynamic compiles
  sudo aptitude -y install dkms

  # If libdbus is not installed, virtualbox will not autostart
  sudo aptitude -y install --without-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  sudo mount -o loop VBoxGuestAdditions.iso /mnt
  yes|sudo /bin/sh /mnt/VBoxLinuxAdditions.run || :
  sudo umount /mnt

  # Start the newly build driver
  sudo /etc/init.d/vboxadd start

  # Clean Up
  rm VBoxGuestAdditions.iso
fi
