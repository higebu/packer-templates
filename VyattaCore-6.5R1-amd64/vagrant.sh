WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
. /etc/bash_completion

# Set up Vagrant.
date | sudo tee /etc/vagrant_box_build_time

# Create the user vagrant with password vagrant
$WRAPPER begin
$WRAPPER set system login user vagrant authentication plaintext-password vagrant
$WRAPPER set system login user vagrant level admin
$WRAPPER commit
$WRAPPER end

# Install vagrant keys
PUBLIC_KEY=$(curl -s 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub')
TYPE=$(echo $PUBLIC_KEY | awk '{print $1}')
KEY=$(echo $PUBLIC_KEY | awk '{print $2}')
$WRAPPER begin
$WRAPPER set system login user vagrant authentication public-keys vagrant type $TYPE
$WRAPPER set system login user vagrant authentication public-keys vagrant key $KEY
$WRAPPER commit
$WRAPPER end

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' | sudo tee /var/run/motd

# Install NFS client
sudo aptitude -y install nfs-common
