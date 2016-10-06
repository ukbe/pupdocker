#!/bin/bash

# Add Puppet server into hosts file
echo "192.168.10.10 puppet.local" >> /etc/hosts

# Get package list
apt-get update

# Install Puppet agent
apt-get -y install rubygems
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install puppet

mkdir -p /etc/puppetlabs/puppet
cp /tmp/puppet.conf /etc/puppetlabs/puppet/

apt-get clean
