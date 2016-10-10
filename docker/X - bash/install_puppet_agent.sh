#!/bin/bash

# Get package list
apt-get update

# Add Puppet server into hosts file
echo "192.168.10.10 puppet.local" >> /etc/hosts

# Install Puppet agent
apt-get -y install rubygems
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install puppet

mkdir /etc/puppetlabs
cp /tmp/puppet.conf /etc/puppetlabs/puppet/

# Enable and run Puppet agent
puppet agent --enable
puppet agent -t
