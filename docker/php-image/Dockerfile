FROM imgpuppet
MAINTAINER Ukbe Akdogan

ARG HOST_IP=172.17.0.1

# Setting the role of the container so Puppet run fetches the right catalog
ENV HOSTROLE=php-fpm

COPY ./.env /root/
#COPY ./empquery.tar.gz /tmp/

RUN set -xe \
  	&& echo ${HOST_IP}"\tpuppet.local" >> /etc/hosts \
    && ( puppet agent -t || test $? -eq 2 )

#COPY ./set_hosts.sh /tmp/
#RUN bash /tmp/set_hosts.sh

VOLUME ["/var/log/php-fpm.log", "/site"]

WORKDIR /usr/sbin/

CMD ["php-fpm7.0"]

EXPOSE 9000