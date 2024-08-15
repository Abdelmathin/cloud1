#!/bin/sh
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "Start..."
rm -rf /tmp/cloud1 && mkdir -p /tmp/cloud1
cd /tmp/cloud1

echo "Install wget & unzip..."
apt-get update && apt-get install -y wget unzip
echo "Install terraform..."
wget "https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip"
unzip "terraform_1.9.4_linux_amd64.zip"
mv terraform /usr/bin
terraform -v
echo "Install aws..."
wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip "awscli-exe-linux-x86_64.zip"
./aws/install
echo "Configure aws ..."
aws configure << EOF
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}




EOF

rm -rf /tmp/cloud1

echo "Deploy..."
cd /home/cloud1/deployment
echo "terraform init..."
terraform init
echo "terraform apply..."
terraform apply -auto-approve
echo "Finish..."