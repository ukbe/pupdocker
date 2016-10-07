FROM imgpuppet
MAINTAINER Ukbe Akdogan

ENV HOSTROLE=webserver

RUN apt-get install -y lsb-release

# Exiting with 0 since Puppet agent exits with 2 if any resource has been changed
#RUN echo "192.168.10.10\tpuppet.local" >> /etc/hosts \
#    && puppet agent -t \
#    && exit 0

COPY ./set_hosts.sh /tmp/
RUN bash /tmp/set_hosts.sh

VOLUME ["/etc/nginx", "/var/log/nginx", "/site"]

WORKDIR /etc/nginx

CMD ["nginx"]

EXPOSE 80
EXPOSE 443