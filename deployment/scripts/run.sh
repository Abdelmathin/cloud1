#!/bin/bash
cd
apt-get update
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
apt-get install -y docker-compose
apt-get install -y git
apt-get install -y python3


mkdir test
cd test
echo '<h1>Hello, Cloud-1!</h1>' > index.html
sudo python3 -m http.server 80
