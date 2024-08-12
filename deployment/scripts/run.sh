#!/bin/bash
cd
apt-get update
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
apt-get install -y docker-compose
apt-get install -y git
apt-get install -y python3

# git clone https://github.com/Abdelmathin/inception inception
# echo "" > srcs/.env
# cd inception && make

mkdir -p /tmp/web443example && echo '<h1>Hello Cloud-1, 443 PORT</h1>' > /tmp/web443example/index.html && sudo python3 -m http.server 443 --directory /tmp/web443example --bind 0.0.0.0 &
mkdir -p /tmp/web80example  && echo '<h1>Hello Cloud-1, 80 PORT</h1>'  > /tmp/web80example/index.html  && sudo python3 -m http.server  80 --directory /tmp/web80example  --bind 0.0.0.0 &
