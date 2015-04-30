#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Add temporary mirror
delete system package repository community
set system package repository community components 'main'
set system package repository community distribution 'helium'
set system package repository community url 'http://mirror.vyos-users.jp/vyos'
commit
save

# Tweak sshd to prevent DNS resolution (speed up logins)
set service ssh disable-host-validation
commit
save

# Disable except tty1
sudo sed -i 's/ACTIVE_CONSOLES=\"\/dev\/tty\[1-6\]\"/ACTIVE_CONSOLES=\"\/dev\/tty1\"/' /etc/default/console-setup
sudo sed -i -e 's,^.*:/sbin/getty\s\+.*\s\+tty[2-6],#\0,' /etc/inittab
