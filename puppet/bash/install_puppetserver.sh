#!/bin/bash

export LC_ALL="en_US.UTF-8"

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb -P /tmp/
sudo dpkg -i /tmp/puppetlabs-release-pc1-xenial.deb
sudo apt-get update

# Install Puppet Server
sudo apt-get install -y puppetserver

sudo cp -r /vagrant/puppet/code /etc/puppetlabs/

sudo cp /vagrant/puppet/autosign.conf /etc/puppetlabs/puppet/
sudo cp /vagrant/puppet/auth.conf /etc/puppetlabs/puppetserver/conf.d/

# Start and enable Puppet Server
sudo systemctl start puppetserver
sudo systemctl enable puppetserver

# Install Puppet modules on master
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-ntp
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-mysql
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppet-nginx
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-docker_platform
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-vcsrepo
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-git
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules Slashbunny-phpfpm

sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true