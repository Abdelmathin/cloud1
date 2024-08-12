#!/bin/bash
apt-get update
apt-get install -y git
apt-get install -y python3
apt-get install -y make
sudo snap install docker
systemctl start docker
systemctl enable docker

if [ -z "${INCEPTION_REPOSITORY_URL}" ]; then
    INCEPTION_REPOSITORY_URL="https://github.com/Abdelmathin/inception"
fi

CLOUD1_REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
INCEPTION_REPOSITORY_PATH="${CLOUD1_REPOSITORY_PATH}/inception"

[ ! -d "${INCEPTION_REPOSITORY_PATH}" ] && cd "${CLOUD1_REPOSITORY_PATH}" && git clone "${INCEPTION_REPOSITORY_URL}" "inception"
sudo echo "${INCEPTION_REPOSITORY_PATH}" > /test.txt
cd "${INCEPTION_REPOSITORY_PATH}"
[ -d "srcs" ] && echo >> srcs/.env && env >> srcs/.env
make re sudo=sudo
