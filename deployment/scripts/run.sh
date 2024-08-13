#!/bin/bash
apt-get update
apt-get install -y git
apt-get install -y python3
apt-get install -y make
snap install docker
systemctl start docker
systemctl enable docker

if [ -z "${INCEPTION_REPOSITORY_URL}" ]; then
    INCEPTION_REPOSITORY_URL="https://github.com/Abdelmathin/inception"
fi

CLOUD1_REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
INCEPTION_REPOSITORY_PATH=/home/ubuntu/inception

[ ! -d "${INCEPTION_REPOSITORY_PATH}" ] && git clone "${INCEPTION_REPOSITORY_URL}" "${INCEPTION_REPOSITORY_PATH}"
sudo echo "${INCEPTION_REPOSITORY_PATH}" > /test.txt
cd "${INCEPTION_REPOSITORY_PATH}"
[ -d "srcs" ] && echo "
INCEPTION_WORKDIR=/home/ubuntu/

# # # # # # # # # # # nginx # # # # # # # # # # #
INCEPTION_PORT=443
INCEPTION_DOMAIN_NAME='52.41.214.79'
INCEPTION_SERVER_NAMES='52.41.214.79'
# # # # # # # # # # wordpress # # # # # # # # # #
INCEPTION_WP_VERSION=6.2
INCEPTION_PHP_VERSION=7.4
INCEPTION_WP_TITLE=WebSite
INCEPTION_WP_USER=ahabachi
INCEPTION_WP_PASSWORD=inception_1337_user
INCEPTION_WP_EMAIL=ahabachi@student.1337.ma
INCEPTION_WP_AUTHOR_USER=abdelmathin
INCEPTION_WP_AUTHOR_MAIL=ahabachi@student.1337.ma
INCEPTION_WP_AUTHOR_PASSWORD=inception_1337_user
INCEPTION_WP_BIND_PORT=9000
INCEPTION_WORDPRESS_VOLUME=/home/ubuntu/data/var/www/wordpress

# # # # # # # # # #  mariadb  # # # # # # # # # #
INCEPTION_DB_NAME=ahabachi
INCEPTION_DB_USER=ahabachi
INCEPTION_DB_PASSWORD=inception_1337_user
INCEPTION_DB_BIND_HOST=mariadb
INCEPTION_DB_BIND_PORT=3306
INCEPTION_DB_ROOT_PASSWORD=inception_1337_root
INCEPTION_MARIADB_VOLUME=/home/ubuntu/data/var/www/mariadb

" > srcs/.env

make re sudo=sudo
