FROM imgpuppet
MAINTAINER Ukbe Akdogan

ENV HOSTROLE=webserver

RUN puppet agent --enable
RUN puppet agent -t

VOLUME /vagrant/vol-webserver/etc/nginx:/etc/nginx
VOLUME /vagrant/vol-webserver/var/www:/var/www
VOLUME /vagrant/vol-webserver/var/log/nginx:/var/log/nginx

EXPOSE 80

ENTRYPOINT ########