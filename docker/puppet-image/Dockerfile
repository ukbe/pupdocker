FROM ubuntu:16.04
MAINTAINER Ukbe Akdogan

COPY ./install_puppet_agent.sh /tmp/
COPY ./puppet.conf /tmp/

RUN bash /tmp/install_puppet_agent.sh

CMD /bin/bash