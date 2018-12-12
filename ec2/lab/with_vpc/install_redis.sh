#!/usr/bin/env bash
sudo yum -y update
sudo yum-config-manager --enable epel
sudo yum install -y redis
sudo rm /etc/redis.conf
sudo cp /tmp/redis.conf /etc
sudo service redis start
