# cloud1
This project is an introduction to cloud servers

## VPC dashboard

https://us-west-2.console.aws.amazon.com/vpcconsole/home?region=us-west-2#Home:

## Instances

https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#Instances:instanceState=running

## Get Started:

```bash
git clone git@github.com:Abdelmathin/cloud1.git
```

```bash
cd cloud1
```

```bash
cat deployment/env.example > deployment/.env # dir hna l keys dyawlk
```

```bash
make
```

## apply:

```bash
cd deployment
```

```bash
terraform init
```

```bash
terraform apply
```

## destroy:

```bash
terraform destroy
```




