FROM imgpuppet
MAINTAINER Ukbe Akdogan

ENV HOSTROLE=php-fpm

COPY ./.env /root/

COPY ./set_hosts.sh /tmp/
RUN bash /tmp/set_hosts.sh

VOLUME ["/var/log/php-fpm.log", "/site"]

WORKDIR /usr/sbin/

CMD ["php-fpm7.0"]

EXPOSE 9000