#!/bin/bash

apt-get install -y puppetmaster-passenger

cp /vagrant/autosign.conf /etc/puppet/
cp /vagrant/puppet.conf /etc/puppet/

puppet module install puppetlabs-docker_platform 
puppet module install puppetlabs-mysql
puppet module install puppetlabs-nginx