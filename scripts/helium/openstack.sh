#!/bin/vbash

# Install vyos-cloudinit
perl -MLWP::Simple -e 'getstore("https://github.com/vyos/vyos-cloudinit/releases/download/v0.3.1/vyos-cloudinit_0.3.1_all.deb", "vyos-cloudinit.deb")'
sudo dpkg -i vyos-cloudinit.deb

# Cleanup
rm vyos-cloudinit.deb

# Setup vyos-cloudinit
source /opt/vyatta/etc/functions/script-template
set service cloudinit environment openstack
commit
save
