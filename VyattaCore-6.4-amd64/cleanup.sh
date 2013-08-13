WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
. /etc/bash_completion

# Clean up
sudo unlink /usr/src/linux
sudo aptitude -y remove linux-vyatta-kbuild build-essential
sudo aptitude -y purge --purge-unused

# Remove Debian squeeze package and Vyatta unstable repository
$WRAPPER begin
$WRAPPER delete system package repository oxnard
$WRAPPER delete system package repository squeeze
$WRAPPER commit
$WRAPPER save
$WRAPPER end

# Removing leftover leases and persistent rules
sudo rm -f /var/lib/dhcp3/*

# Removing hw-id
$WRAPPER begin
$WRAPPER delete interfaces ethernet eth0 hw-id
$WRAPPER commit
$WRAPPER save
$WRAPPER end

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" | sudo tee -a /etc/network/interfaces
