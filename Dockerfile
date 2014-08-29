# Dockerizing Workbench: Dockerfile for building Workbench images
# Based on ubuntu:latest
# - installs MongoDB
# - installs Bro IDS
# - installs ElasticSearch
# - installs Workbench

FROM       phusion/baseimage:0.9.13
MAINTAINER briford.wylie@gmail.com

### Phusion Stuff ###
# Set correct environment variables.
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

### My Stuff ###
# Install a bunch of default stuff
RUN apt-get update && apt-get install -y tar git curl wget dialog net-tools build-essential

# Install python and pip
RUN apt-get install -y python python-dev python-distribute python-pip

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  mkdir -p /data/db

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Install Bro IDS
RUN apt-get install -y libgeoip1
RUN apt-get install -y libpcap0.8
RUN apt-get install -y libssl0.9.8
RUN wget https://s3-us-west-2.amazonaws.com/workbench-data/packages/Bro-2.2-Linux-x86_64_flex.deb && \
  dpkg -i Bro-2.2-Linux-x86_64_flex.deb
ENV PATH /opt/bro/bin:$PATH

# Install workbench
RUN pip install workbench --pre

# Adding stuff to runit
RUN mkdir /etc/service/mongo
ADD mongo.sh /etc/service/mongo/run
RUN mkdir /etc/service/workbench
ADD workbench.sh /etc/service/workbench/run

### Phusion Stuff ###
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Expose ports.
#   - 4242: workbench
#   - 27017: mongo process
#   - 28017: mongo http
EXPOSE 4242
EXPOSE 27017
EXPOSE 28017
