# apiaxle
# this file is at https://github.com/lexlapax/dockerfile-apiaxle/blob/master/Dockerfile
# based on install instructions from 
# http://apiaxle.com/docs/try-it-now/
FROM ubuntu:precise
MAINTAINER Lex Lapax <lexlapax@gmail.com>

# Update the APT cache
ENV DEBIAN_FRONTEND noninteractive
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Hack for initctl
# See: https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Install and setup project dependencies
RUN apt-get install -y curl lsb-release supervisor openssh-server python-software-properties build-essential libxml2-dev

RUN add-apt-repository ppa:chris-lea/node.js -y
RUN apt-get update
RUN apt-get install -y redis-server nodejs 

RUN mkdir -p /var/run/sshd

RUN locale-gen en_US en_US.UTF-8

RUN npm install -g apiaxle-repl apiaxle-proxy apiaxle-api

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo 'root:apiaxle' | chpasswd

# Expose Protocol Buffers and HTTP interfaces
EXPOSE 3000 22

CMD ["/usr/bin/supervisord"]
