# cloud1
This project is an introduction to cloud servers

https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#Instances:instanceState=running

## Get Started:

```bash
cat << EOL > deployment/.env
AWS_ACCESS_KEY_ID=(YOUR AWS_ACCESS_KEY_ID HERE)
AWS_SECRET_ACCESS_KEY=(YOUR AWS_SECRET_ACCESS_KEY HERE)
EOL
make
```

## How to delpoy:

```bash
cd deployment
terraform init
terraform delpoy
```