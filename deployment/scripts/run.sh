#!/bin/bash

apt-get update
apt-get install -y docker.io
apt-get install -y docker-compose
apt-get install -y git
apt-get install -y python3

systemctl start docker
systemctl enable docker

CLOUD1_REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
INCEPTION_REPOSITORY_PATH="${CLOUD1_REPOSITORY_PATH}/inception"

[ ! -d "${INCEPTION_REPOSITORY_PATH}" ] && cd "${CLOUD1_REPOSITORY_PATH}" && git clone "https://github.com/Abdelmathin/inception" "inception"

cd "${INCEPTION_REPOSITORY_PATH}"
mkdir -p srcs && env > srcs/.env

python3 -m http.server  80 --directory . --bind 0.0.0.0 &
python3 -m http.server 443 --directory . --bind 0.0.0.0 &
