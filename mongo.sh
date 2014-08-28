#!/bin/sh
exec /usr/bin/mongod --smallfiles >>/var/log/mongo.log 2>&1
