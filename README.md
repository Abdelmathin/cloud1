# 🚀 Deploying a WordPress Website with MariaDB and Nginx on AWS Using Terraform

<p align="center">
    <a href="" target="_blank">
        <img style="border-radius: 10px;" src="docs/assets/img/banner.png" width="" alt="Terraform + AWS" />
    </a>
</p>

Welcome to the `cloud1` project! This project serves as an introduction to deploying and managing cloud infrastructure using AWS. It walks you through setting up a VPC, EC2 instances, and managing your resources with Terraform.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
  - [Cloning the Repository](#cloning-the-repository)
  - [Setting Up Environment Variables](#setting-up-environment-variables)
  - [Deployment](#deployment)
  - [Destroying Resources](#destroying-resources)
  - [Running Terraform with Vagrant](#running-terraform-with-vagrant)
  - [Vagrant Configuration](#vagrant-configuration)
- [AWS Console Links](#aws-console-links)

## Overview

This project automates cloud infrastructure deployment on AWS using Terraform. It includes the following:
- VPC setup
- EC2 instances
- Automated deployment using Make and Terraform

## ✅&nbsp; Prerequisites

Before you begin, make sure you have the following installed on your machine:
- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/)
- [Git](https://git-scm.com/)
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Make](https://www.gnu.org/software/make/)

You'll also need an AWS account with the necessary permissions to create resources such as VPCs and EC2 instances.

## Key Components
- **WordPress:** The popular content management system (CMS).
- **MariaDB:** The relational database management system.
- **Nginx:** The high-performance web server.
- **Terraform:** The infrastructure as code tool used for provisioning and managing cloud resources.

## Deployment Steps
- Configure your AWS environment for hosting WordPress.
- Set up a MariaDB database.
- Configure Nginx as the web server for your WordPress site.
- Manage the entire deployment process with Terraform.

---

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

> [!NOTE]  
> The keys below are just fake examples. Replace them with your actual AWS credentials in the .env file.

> ```bash
> AWS_ACCESS_KEY_ID=AKIAXYKJVQUW7ZFRCXUW
> AWS_SECRET_ACCESS_KEY=LAfhkfj8PUKDOhxGVTduGS2173R5O4FQjYhXJItI
> ```

## Certificate File

The `cloud1.cer` file is a certificate used for secure communication between your application and the AWS services. It is essential for ensuring that your connections are encrypted and trustworthy. This certificate may be required for various services, including database connections or API calls, to verify the identity of the server you are communicating with. Make sure to keep this file secure and only share it with trusted applications and environments. 


### Deployment

To deploy the infrastructure, navigate to the `deployment` directory, initialize Terraform, and apply the configuration:

```bash
cd deployment
terraform init
terraform apply
```

### Destroying Resources

To destroy all the cloud resources when you no longer need them:

```bash
terraform destroy
```

### Running Terraform with Vagrant

You can also run the previous example with this Vagrantfile. This allows you to manage your infrastructure in a consistent environment without needing to configure Terraform and other dependencies directly on your local machine.

1. **Start the Vagrant VM:**

Navigate to the root of the project directory and bring up the Vagrant VM:

```bash
vagrant up
```

2. **SSH into the VM:**
Once the VM is up, SSH into it:

```bash
vagrant ssh
```

3. **Navigate to the synced folder:**
Inside the VM, navigate to the synced project folder:

```bash
cd /home/vagrant/cloud1
```

4. **Do previous steps:**

Follow the steps for setting up environment variables and initializing Terraform as previously described.

### Vagrant Configuration

The following Vagrantfile sets up a virtual machine using Vagrant and VirtualBox as the provider.

```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
    end

    config.vm.provision "shell", path: "./scripts/setup-ubuntu.sh"
    config.vm.synced_folder "../", "/home/vagrant/cloud1"
end
```

### AWS Console Links

- [VPC Dashboard](https://us-west-2.console.aws.amazon.com/vpcconsole/home?region=us-west-2#Home)
- [EC2 Instances](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#Instances:instanceState=running)

### ❤️&nbsp; Get Involved
If you have any questions, suggestions, or improvements regarding this deployment process, feel free to open an issue or submit a pull request in the repository. Your contributions are always welcome!

Thank you for using this guide, and happy coding! 🎉

## 📘&nbsp; License

This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for more details.

### GNU General Public License v3.0

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the [GNU General Public License](https://www.gnu.org/licenses/) for more details.


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



