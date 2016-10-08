#!/bin/bash

# Add Puppet server into hosts file
echo "192.168.10.10 puppet.local" >> /etc/hosts
cat /etc/hosts
#cat /etc/hosts

#apt-get install -y lsb-release
#puppet agent --enable
puppet agent -t

# Revoke client certificate on Puppet server since
# we won't be accessing the Puppet server with this hostname
#curl --cert /etc/puppetlabs/puppet/ssl/certs/${HOSTNAME}.pem \
#     --key /etc/puppetlabs/puppet/ssl/private_keys/${HOSTNAME}.pem \
#     --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
#     -X PUT -H "Content-Type: application/json" -d '{"desired_state":"revoked"}' \
#     https://puppet.local:8140/puppet-ca/v1/certificate_status/${HOSTNAME}

# Delete client certificate on Puppet server since
#curl --cert /etc/puppetlabs/puppet/ssl/certs/${HOSTNAME}.pem \
#     --key /etc/puppetlabs/puppet/ssl/private_keys/${HOSTNAME}.pem \
#     --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
#     -X DELETE -d '{"desired_state":"revoked"}' \
#     https://puppet.local:8140/puppet-ca/v1/certificate_status/${HOSTNAME}

exit 0