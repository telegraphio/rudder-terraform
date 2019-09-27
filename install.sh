#!/bin/bash

# Started At
echo $(date +'%Y-%m-%d %T') > /home/ubuntu/installed_started_at 


# setup postgres on the same machine
echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | sudo tee -a /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get -y install postgresql-10

sudo -u postgres createdb "jobsdb"``
sudo -u postgres createuser --superuser "rudder"
sudo -u postgres psql "jobsdb" -c "alter user rudder with encrypted password 'rudderpwd'";
sudo -u postgres psql "jobsdb" -c "grant all privileges on database jobsdb to rudder ;";


# setup Node.js
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get -y install nodejs
npm install -g pm2

chown -R ubuntu:ubuntu ~/.npm


# install latest AWS CLI
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
apt install -y unzip python-minimal
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -rf ./awscli-bundle awscli-bundle.zip

# Completed At
echo $(date +'%Y-%m-%d %T') > /home/ubuntu/installed_completed_at
