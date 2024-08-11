# cloud1
This project is an introduction to cloud servers

https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#Instances:instanceState=running

## Get Started:

```bash
git clone git@github.com:Abdelmathin/cloud1.git
```

```bash
cd cloud1
```

```bash
echo 'AWS_ACCESS_KEY_ID=(YOUR AWS_ACCESS_KEY_ID HERE)' >> deployment/.env
```

```bash
echo 'AWS_SECRET_ACCESS_KEY=(YOUR AWS_SECRET_ACCESS_KEY HERE)' >> deployment/.env
```

```bash
make
```

## How to delpoy:

```bash
cd deployment
terraform init
terraform delpoy
```