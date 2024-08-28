#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
INCEPTION_WORKDIR="/home/ubuntu"
#
cd "${INCEPTION_WORKDIR}"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
sudo apt update  -y
# # # # # # # # # # # # Configure Make # # # # # # # # # # # #
sudo apt install -y make
# # # # # # # # # # # # Configure Python # # # # # # # # # # #
( DEBIAN_FRONTEND=noninteractive && sudo apt install -y tzdata  )
( DEBIAN_FRONTEND=noninteractive && sudo apt install -y python3 )
# # # # # # # # # # # # Configure SSH  # # # # # # # # # # # # #
sudo apt install -y openssh-server
sudo systemctl start  ssh
sudo systemctl enable ssh
sudo systemctl status ssh --no-pager
# # # # # # # # # # # # Configure Docker # # # # # # # # # # # #
snap install   docker
sudo systemctl start docker
sudo systemctl enable docker

# # # # # # # # # # # # Configure Service # # # # # # # # # # # #
echo "
[Unit]
Description=This project is an introduction to cloud servers.
After=network.target
StartLimitIntervalSec=300

[Service]
ExecStart=bash -c 'date >> ${INCEPTION_WORKDIR}/restart.log && cd ${INCEPTION_WORKDIR}/inception && sudo make sudo=sudo && /usr/bin/tail -f /dev/null'
Restart=always

[Install]
WantedBy=multi-user.target

" > "/etc/systemd/system/cloud1.service"

sudo systemctl start  cloud1.service             > /dev/null 2> /dev/null
sudo systemctl enable cloud1.service             > /dev/null 2> /dev/null
sudo systemctl status cloud1.service --no-pager  > /dev/null 2> /dev/null
