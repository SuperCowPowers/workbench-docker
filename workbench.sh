#!/bin/sh
exec /sbin/setuser mongodb /usr/bin/mongod --smallfiles >>/var/log/mongo.log 2>&1
exec /usr/local/bin/workbench_server >>/var/log/workbench.log 2>&1
