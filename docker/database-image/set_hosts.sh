#!/bin/bash

# Add Puppet server into hosts file
echo "192.168.10.10 puppet.local" >> /etc/hosts

rm -rf /etc/puppetlabs/puppet/ssl

puppet agent --enable
puppet agent -t