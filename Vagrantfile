# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.10.10"
  # config.vm.network "public_network"

  config.vm.hostname = "dockerhost"
  config.vm.box = "ubuntu/xenial64"
  # config.vm.synced_folder "../data", "/vagrant_data"

#  config.librarian_puppet.puppetfile_dir = 'puppet/'

  config.vm.provision "shell", path: "install_puppetmaster.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
  end

end
