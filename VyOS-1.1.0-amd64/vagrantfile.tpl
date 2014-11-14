# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # SSH in as the default 'vyos' user, it has the vagrant ssh key.
  config.ssh.username = "vyos"
end
