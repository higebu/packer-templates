#!/bin/vbash

# Install pip
perl -MLWP::Simple -e 'getstore("https://bootstrap.pypa.io/get-pip.py", "get-pip.py")'
sudo python get-pip.py

# Install awscli
sudo pip install awscli

# Disable ec2-fetch-ssh-public-key
sudo update-rc.d ec2-fetch-ssh-public-key disable

# Install vyos-cloudinit
perl -MLWP::Simple -e 'getstore("https://github.com/higebu/vyos-cloudinit/releases/download/v0.3.1/vyos-cloudinit_0.3.1_all.deb", "vyos-cloudinit.deb")'
sudo dpkg -i vyos-cloudinit.deb

# Cleanup
rm get-pip.py
rm vyos-cloudinit.deb

# Setup vyos-cloudinit
source /opt/vyatta/etc/functions/script-template
set service cloudinit environment ec2
commit
save
