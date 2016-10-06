FROM imgpuppet
MAINTAINER Ukbe Akdogan

ENV HOSTROLE=database

COPY ./set_hosts.sh /tmp/

RUN bash /tmp/set_hosts.sh

VOLUME /vagrant/vol-database/etc/mysql:/etc/mysql
VOLUME /vagrant/vol-database/var/lib/mysql:/var/lib/mysql
VOLUME /vagrant/vol-database/var/log/mysql:/var/log/mysql

EXPOSE 3306

ENTRYPOINT /usr/sbin/mysqld
