#!/bin/bash

export LC_ALL="en_US.UTF-8"

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb -P /tmp/
sudo dpkg -i /tmp/puppetlabs-release-pc1-xenial.deb
sudo apt-get update

# Install Puppet Server
sudo apt-get install -y puppetserver

sudo cp -r /vagrant/puppet/code /etc/puppetlabs/

# Start and enable Puppet Server
sudo systemctl start puppetserver
sudo systemctl enable puppetserver

#cp /vagrant/autosign.conf /etc/puppet/
#cp /vagrant/puppet.conf.master /etc/puppet/puppet.conf

# Install Puppet modules on master
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-ntp
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-mysql
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-nginx
sudo /opt/puppetlabs/bin/puppet module install -i /etc/puppetlabs/code/modules puppetlabs-docker_platform

sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true