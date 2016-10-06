FROM imgpuppet
MAINTAINER Ukbe Akdogan

ENV HOSTROLE=webserver

COPY ./set_hosts.sh /tmp/

RUN bash /tmp/set_hosts.sh

VOLUME /vagrant/vol-webserver/etc/nginx:/etc/nginx
VOLUME /vagrant/vol-webserver/var/www:/var/www
VOLUME /vagrant/vol-webserver/var/log/nginx:/var/log/nginx

EXPOSE 80

CMD service nginx start