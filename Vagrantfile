# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.10.10"
  # config.vm.network "public_network"

  config.vm.hostname = "puppet.local"
  config.vm.box = "ubuntu/xenial64"
  # config.vm.synced_folder "../data", "/vagrant_data"

#  config.librarian_puppet.puppetfile_dir = 'puppet/'

  config.vm.provision "shell", path: "puppet/bash/install_puppetserver.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end

  #config.vm.provision "puppet" do |puppet|
  #  puppet.module_path = "puppet/modules"
  #  puppet.manifests_path = "puppet/manifests"
  #end

end
