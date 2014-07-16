# apiaxle
# this file is at https://github.com/lexlapax/dockerfile-apiaxle/blob/master/Dockerfile
# based on install instructions from 
# http://apiaxle.com/docs/try-it-now/
#FROM ubuntu:precise
FROM ubuntu:trusty
MAINTAINER Lex Lapax <lexlapax@gmail.com>

# Update the APT cache
ENV DEBIAN_FRONTEND noninteractive
USER root
RUN echo "deb http://us.archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list
RUN \ 
	apt-get update ;\
	apt-get upgrade -y ;\
	apt-get install build-essential libtool libssl-dev python-distutils-extra python-software-properties wget curl git sudo -y

# Hack for initctl
# See: https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN adduser --system --shell /bin/bash --gecos 'generic container user'' --home /home/cuser cuser; usermod -a -G sudo cuser ;

RUN echo 'cuser:baseimg' | chpasswd

RUN mkdir -p /var/run/sshd /var/log/supervisord 

# Install and setup project dependencies
RUN apt-get install -y lsb-release supervisor openssh-server 


ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN locale-gen en_US en_US.UTF-8
# Done base image setup

# start with specifics for this image
RUN apt-get install -y libxml2-dev redis-server

#RUN add-apt-repository ppa:chris-lea/node.js -y
#RUN apt-get update
RUN apt-get install -y rlwrap nodejs 

RUN npm install -g apiaxle-repl apiaxle-proxy apiaxle-api

# Expose Protocol Buffers and HTTP interfaces
EXPOSE 3000 22 6379

CMD ["/usr/bin/supervisord"]
