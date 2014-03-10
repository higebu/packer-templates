set -x

if test -f VBoxGuestAdditions.iso ; then

  # Install dkms for dynamic compiles
  sudo aptitude -y install dkms

  # If libdbus is not installed, virtualbox will not autostart
  sudo aptitude -y install --without-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  sudo mount -o loop VBoxGuestAdditions.iso /mnt
  yes|sudo /bin/sh /mnt/VBoxLinuxAdditions.run
  sudo umount /mnt

  # Start the newly build driver
  sudo /etc/init.d/vboxadd start

  # Clean Up
  rm VBoxGuestAdditions.iso
fi
