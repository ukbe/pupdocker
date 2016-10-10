FROM imgpuppet
MAINTAINER Ukbe Akdogan

ARG HOST_IP=172.17.0.1

# Setting the role of the container so Puppet run fetches the right catalog
ENV HOSTROLE=database

#COPY ./test_db-master.tar.gz /root/

RUN set -xe \
  	&& echo ${HOST_IP}"\tpuppet.local" >> /etc/hosts \
    && ( puppet agent -t || test $? -eq 2 )

#COPY ./set_hosts.sh /tmp/
#RUN bash /tmp/set_hosts.sh

VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log/mysql"]

CMD ["mysqld"]

EXPOSE 3306
