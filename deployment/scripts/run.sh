#!/bin/bash
cd
apt-get update
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
apt-get install -y docker-compose
apt-get install -y git
apt-get install -y python3

git clone https://github.com/Abdelmathin/inception inception
cd inception && make


mkdir -p inception
cd inception
# echo "" > srcs/.env

echo "<h1>Hello, {var.env_example_key}!</h1>" > index.html
sudo python3 -m http.server 80
