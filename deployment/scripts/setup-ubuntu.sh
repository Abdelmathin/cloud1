#!/bin/sh

cat <<EOL > /home/vagrant/cloud1/test-env
[default]
aws_access_key_id     = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOL

rm -rf /tmp/cloud1 && mkdir -p /tmp/cloud1
cd /tmp/cloud1

apt-get update && apt-get install -y wget unzip
wget "https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip"
unzip "terraform_1.9.4_linux_amd64.zip"
mv terraform /usr/bin
terraform -v

wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip "awscli-exe-linux-x86_64.zip"
./aws/install

mkdir -p ~/.aws
cat <<EOL > ~/.aws/credentials
[default]
aws_access_key_id     = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOL


rm -rf /tmp/cloud1