#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo apt-get install -y docker-compose
sudo apt-get install -y git
sudo apt-get install -y python3
sudo apt-get install -y make
sudo systemctl start docker
sudo systemctl enable docker

if [ -z "${INCEPTION_REPOSITORY_URL}" ]; then
    INCEPTION_REPOSITORY_URL="https://github.com/Abdelmathin/inception"
fi

CLOUD1_REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
INCEPTION_REPOSITORY_PATH="${CLOUD1_REPOSITORY_PATH}/inception"

[ ! -d "${INCEPTION_REPOSITORY_PATH}" ] && cd "${CLOUD1_REPOSITORY_PATH}" && git clone "${INCEPTION_REPOSITORY_URL}" "inception"

cd "${INCEPTION_REPOSITORY_PATH}"
# [ -d "srcs" ] && env > srcs/.env
sudo make re
