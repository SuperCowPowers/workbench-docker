# Dockerizing Workbench: Dockerfile for building Workbench images
# Based on ubuntu:latest
# - installs MongoDB
# - installs Bro IDS
# - installs ElasticSearch
# - installs Workbench

FROM       ubuntu:latest
MAINTAINER Docker

# Install bash
RUN apt-get update && apt-get install bash

# Install MongoDB
RUN apt-get update && apt-get install -y mongodb

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Expose port #27017 from the container to the host
EXPOSE 27017

# Set /usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT ["/usr/bin/mongod"]
