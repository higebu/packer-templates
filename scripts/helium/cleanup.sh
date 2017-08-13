#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Removing leftover leases and persistent rules
sudo rm -f /var/lib/dhcp3/*

# Removing apt caches
sudo rm -rf /var/cache/apt/*

# Removing hw-id
delete interfaces ethernet eth0 hw-id

set service ssh disable-password-authentication
commit
save

sudo rm -v /etc/ssh/ssh_host_*
