# Dockerizing Workbench: Dockerfile for building Workbench images
# Based on ubuntu:latest
# - installs MongoDB
# - installs Bro IDS
# - installs ElasticSearch
# - installs Workbench

FROM       ubuntu:latest
MAINTAINER briford.wylie@gmail.com

# Install a bunch of default stuff
RUN apt-get update && apt-get install -y tar git curl wget dialog net-tools build-essential

# Install python and pip
RUN apt-get install -y python python-dev python-distribute python-pip

# Overwrite the policy rc file so that we can start MongoDB later
RUN echo '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

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

# Install Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install workbench
RUN pip install workbench --pre

# Define supervisor command which runs both MongoDB and workbench_server
CMD ["/usr/bin/supervisord"]

# Expose ports.
#   - 4242: workbench
#   - 27017: mongo process
#   - 28017: mongo http
EXPOSE 4242
EXPOSE 27017
EXPOSE 28017
