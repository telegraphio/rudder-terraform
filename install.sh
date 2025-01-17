#!/bin/bash

# Started At
echo $(date +'%Y-%m-%d %T') > /home/ubuntu/installed_started_at 


# setup postgres on the same machine
# echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | sudo tee -a /etc/apt/sources.list.d/pgdg.list
# wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# apt-get update
# apt-get -y install postgresql-10

apt update && apt upgrade -y

apt install -y postgresql

sudo -u postgres createdb "jobsdb"``
sudo -u postgres createuser --superuser "rudder"
sudo -u postgres psql "jobsdb" -c "alter user rudder with encrypted password 'rudderpwd'";
sudo -u postgres psql "jobsdb" -c "grant all privileges on database jobsdb to rudder ;";

# setup nginx
apt -y install nginx
sudo rm /etc/nginx/sites-available/default
sudo cat << EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;

    server_tokens off;
    server_name rs.telegraph.io;

    ssl_certificate /etc/nginx/certs/rs.telegraph.io.crt;
    ssl_certificate_key /etc/nginx/certs/rs.telegraph.io.key;

    client_max_body_size 20m;

    location / {
        rewrite ^(.*)$ https://telegraph.io$1 permanent;
    }

    location /rs/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_redirect off;
        proxy_read_timeout 300s;

        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF
sudo mkdir -p /etc/nginx/certs
sudo cp /home/ubuntu/rs.telegraph.io.crt /etc/nginx/certs/rs.telegraph.io.crt
sudo cp /home/ubuntu/rs.telegraph.io.key /etc/nginx/certs/rs.telegraph.io.key
sudo systemctl enable nginx
sudo systemctl restart nginx

# setup Node.js
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
# apt-get -y install nodejs
apt install -y nodejs
npm install -g pm2

# apt-get -y install python make g++
apt -y install

chown -R ubuntu:ubuntu ~/.npm


# install latest AWS CLI
# curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
# apt install -y unzip python-minimal
# unzip awscli-bundle.zip
# sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
# rm -rf ./awscli-bundle awscli-bundle.zip
apt install -y awscli

# Completed At
echo $(date +'%Y-%m-%d %T') > /home/ubuntu/installed_completed_at
