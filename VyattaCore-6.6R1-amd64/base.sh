WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
. /etc/bash_completion

sudo aptitude -y update

# Add Debian squeeze package repository
$WRAPPER begin
$WRAPPER delete system package repository community
$WRAPPER set system package repository squeeze url http://ftp.jp.debian.org/debian/
$WRAPPER set system package repository squeeze distribution squeeze
$WRAPPER set system package repository squeeze components main
$WRAPPER set system package repository daisy url http://packages.vyatta.com/vyatta-dev/daisy/unstable
$WRAPPER set system package repository daisy distribution daisy
$WRAPPER set system package repository daisy components main
$WRAPPER commit
$WRAPPER save
$WRAPPER end

# Install build-essential and linux-vyatta-kbuild
sudo aptitude -y update
sudo aptitude -y install build-essential
sudo aptitude -y install linux-vyatta-kbuild
sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyatta-virt /usr/src/linux
sudo ln -s /usr/src/linux-image/debian/build/build-amd64-none-amd64-vyatta-virt /lib/modules/$(uname -r)/build

# Tweak sshd to prevent DNS resolution (speed up logins)
$WRAPPER begin
$WRAPPER set service ssh disable-host-validation
$WRAPPER commit
$WRAPPER save
$WRAPPER end
