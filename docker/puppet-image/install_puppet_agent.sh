#!/bin/bash

# Add Puppet server into hosts file
echo 192.168.10.10 puppet.local >> /etc/hosts

cat /etc/hosts

# Get package list
apt-get update

# Install Puppet agent
apt-get -y install rubygems curl
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install puppet

mkdir -p /etc/puppetlabs/puppet
cp /tmp/puppet.conf /etc/puppetlabs/puppet/

# Revoke client certificate on Puppet server since
# we won't be accessing the Puppet server with this hostname
curl --cert /etc/puppetlabs/puppet/ssl/certs/${HOSTNAME}.pem \
     --key /etc/puppetlabs/puppet/ssl/private_keys/${HOSTNAME}.pem \
     --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
     -X PUT -H "Content-Type: application/json" -d '{"desired_state":"revoked"}' \
     https://puppet.local:8140/puppet-ca/v1/certificate_status/${HOSTNAME}

# Delete client certificate on Puppet server since
curl --cert /etc/puppetlabs/puppet/ssl/certs/${HOSTNAME}.pem \
     --key /etc/puppetlabs/puppet/ssl/private_keys/${HOSTNAME}.pem \
     --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
     -X DELETE -d '{"desired_state":"revoked"}' \
     https://puppet.local:8140/puppet-ca/v1/certificate_status/${HOSTNAME}

# Delete client certificate and key on Puppet server since
rm -rf /etc/puppetlabs/puppet/ssl

apt-get clean
