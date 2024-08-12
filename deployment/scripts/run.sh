#!/bin/bash

apt-get update
apt-get install -y docker.io
apt-get install -y docker-compose
apt-get install -y git
apt-get install -y python3

systemctl start docker
systemctl enable docker

if [ -z "${INCEPTION_REPOSITORY_URL}" ]; then
    INCEPTION_REPOSITORY_URL="https://github.com/Abdelmathin/inception"
fi

CLOUD1_REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
INCEPTION_REPOSITORY_PATH="${CLOUD1_REPOSITORY_PATH}/inception"

[ ! -d "${INCEPTION_REPOSITORY_PATH}" ] && cd "${CLOUD1_REPOSITORY_PATH}" && git clone "${INCEPTION_REPOSITORY_URL}" "inception"

cd "${INCEPTION_REPOSITORY_PATH}"
[ -d "srcs" ] && env > srcs/.env

python3 -m http.server  80 --directory . --bind 0.0.0.0 &
python3 -m http.server 443 --directory . --bind 0.0.0.0 &
