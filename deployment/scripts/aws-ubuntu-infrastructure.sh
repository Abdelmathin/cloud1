#!/bin/bash
INCEPTION_WORKDIR="/home/ubuntu"
INCEPTION_REPOSITORY_URL="https://github.com/Abdelmathin/inception"
#
cd "${INCEPTION_WORKDIR}"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
sudo apt update  -y
sudo apt install -y curl
# # # # # # # # # # # # Configure Make # # # # # # # # # # # #
sudo apt install -y make
# # # # # # # # # # # # Configure git  # # # # # # # # # # # #
sudo apt install -y git
# # # # # # # # # # # # Configure Python # # # # # # # # # # #
( DEBIAN_FRONTEND=noninteractive && sudo apt install -y tzdata  )
( DEBIAN_FRONTEND=noninteractive && sudo apt install -y python3 )
# # # # # # # # # # # # Configure SSH  # # # # # # # # # # # # #
sudo apt install -y openssh-server
sudo systemctl start  ssh             > /dev/null 2> /dev/null
sudo systemctl enable ssh             > /dev/null 2> /dev/null
sudo systemctl status ssh --no-pager  > /dev/null 2> /dev/null
# # # # # # # # # # # # Configure Docker # # # # # # # # # # # #
snap install   docker
sudo systemctl start docker
sudo systemctl enable docker

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo "
[Unit]
Description=This project is an introduction to cloud servers
After=network.target
StartLimitIntervalSec=0

[Service]
RestartSec=5
ExecStart=bash -c 'cd ${INCEPTION_WORKDIR} && date >> restart.log && cd inception && sudo make sudo=sudo'


[Install]
WantedBy=multi-user.target

" > "/etc/systemd/system/cloud1.service"

sudo systemctl start  cloud1.service             > /dev/null 2> /dev/null
sudo systemctl enable cloud1.service             > /dev/null 2> /dev/null
sudo systemctl status cloud1.service --no-pager  > /dev/null 2> /dev/null

sudo git clone "${INCEPTION_REPOSITORY_URL}" "inception"

sudo echo "

INCEPTION_WORKDIR=${INCEPTION_WORKDIR}

# # # # # # # # # # # nginx # # # # # # # # # # #
INCEPTION_PORT=443
INCEPTION_PORTS=443
INCEPTION_DOMAIN_NAME=mhcloud1.tech
INCEPTION_SERVER_NAMES=mhcloud1.tech
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
INCEPTION_WORDPRESS_VOLUME=${INCEPTION_WORKDIR}/data/var/www/wordpress

# # # # # # # # # #  mariadb  # # # # # # # # # #
INCEPTION_DB_NAME=ahabachi
INCEPTION_DB_USER=ahabachi
INCEPTION_DB_PASSWORD=inception_1337_user
INCEPTION_DB_BIND_HOST=mariadb
INCEPTION_DB_BIND_PORT=3306
INCEPTION_DB_ROOT_PASSWORD=inception_1337_root
INCEPTION_MARIADB_VOLUME=${INCEPTION_WORKDIR}/data/var/www/mariadb

" > "inception/srcs/.env"

cd "inception" && sudo make sudo=sudo
