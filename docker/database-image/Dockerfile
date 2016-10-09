FROM imgpuppet
MAINTAINER Ukbe Akdogan

# Setting the role of the container so Puppet run fetches the right catalog
ENV HOSTROLE=database

#RUN set -xe \
#  	&& echo "192.168.10.10\tpuppet.local" >> /etc/hosts \
#    && puppet agent -t
COPY ./test_db-master.tar.gz /root/

COPY ./set_hosts.sh /tmp/
RUN bash /tmp/set_hosts.sh

VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log/mysql"]

CMD ["mysqld"]

EXPOSE 3306
