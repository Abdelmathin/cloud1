# Cloud1

Welcome to the `cloud1` project! This project serves as an introduction to deploying and managing cloud infrastructure using AWS. It walks you through setting up a VPC, EC2 instances, and managing your resources with Terraform.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
  - [Cloning the Repository](#cloning-the-repository)
  - [Setting Up Environment Variables](#setting-up-environment-variables)
  - [Deployment](#deployment)
  - [Destroying Resources](#destroying-resources)
- [AWS Console Links](#aws-console-links)

## Overview

This project automates cloud infrastructure deployment on AWS using Terraform. It includes the following:
- VPC setup
- EC2 instances
- Automated deployment using Make and Terraform

## Prerequisites

Before you begin, make sure you have the following installed on your machine:
- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/)
- [Git](https://git-scm.com/)
- [Make](https://www.gnu.org/software/make/)

You'll also need an AWS account with the necessary permissions to create resources such as VPCs and EC2 instances.

## Quick Start

### Cloning the Repository

To get started, clone the repository using Git:

```bash
git clone git@github.com:Abdelmathin/cloud1.git
cd cloud1
```

### Setting Up Environment Variables

Copy the example environment file to create your own `.env` file, then replace the placeholders with your AWS keys and configurations:

```bash
cat deployment/env.example > deployment/.env
```
[NOTE]
Note: The keys below are just fake examples. Replace them with your actual AWS credentials in the .env file.

```bash
AWS_ACCESS_KEY_ID=AKIAXYKJVQUW7ZFRCXUW
AWS_SECRET_ACCESS_KEY=LAfhkfj8PUKDOhxGVTduGS2173R5O4FQjYhXJItI
```


<!--
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
-->



