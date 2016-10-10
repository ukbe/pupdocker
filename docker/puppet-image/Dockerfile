FROM ubuntu:16.04
MAINTAINER Ukbe Akdogan

ARG HOST_IP=172.17.0.1

COPY ./puppet.conf /tmp/

RUN set -xe \
  	&& echo ${HOST_IP}"\tpuppet.local" >> /etc/hosts \
    && apt-get update && apt-get -y install rubygems curl lsb-release \
    && echo "gem: --no-ri --no-rdoc" > ~/.gemrc && gem install puppet \
    && mkdir -p /etc/puppetlabs/puppet && cp /tmp/puppet.conf /etc/puppetlabs/puppet/ \
    && puppet agent --enable && ( puppet agent -t || test $? -eq 2 )

CMD /bin/bash