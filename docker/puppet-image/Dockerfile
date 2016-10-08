FROM ubuntu:16.04
MAINTAINER Ukbe Akdogan

COPY ./puppet.conf /tmp/

RUN set -xe \
  	&& echo "192.168.10.10\tpuppet.local" >> /etc/hosts && cat /etc/hosts \
    && apt-get update && apt-get -y install rubygems curl lsb-release \
    && echo "gem: --no-ri --no-rdoc" > ~/.gemrc && gem install puppet \
    && mkdir -p /etc/puppetlabs/puppet && cp /tmp/puppet.conf /etc/puppetlabs/puppet/ \
    && puppet agent --enable && puppet agent -t

CMD /bin/bash