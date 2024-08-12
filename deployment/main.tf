provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "inception-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone      = "us-west-2a"  # Replace with your desired AZ
  tags = {
    Name = "inception-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"  # Replace with your desired AZ
  tags = {
    Name = "inception-private-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "inception-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "inception-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "inception-web-sg"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-08c47e4b2806964ce"  # Example Ubuntu AMI (replace with your preferred AMI)
  instance_type = "t2.2xlarge"             # Instance type
  subnet_id     = aws_subnet.public.id     # Place the instance in the public subnet

  key_name      = "cloud1"                 # Replace with your actual key pair name

  vpc_security_group_ids = [aws_security_group.web.id]  # Attach the security group using vpc_security_group_ids

  tags = {
    Name = "inception-web-server"
  }

  user_data = <<-EOF
               #!/bin/bash
              apt-get update
              
              # Install Docker
              sudo snap install docker
              
              
              
              EOF

  # File provisioners with explicit connection block
  provisioner "file" {
    source      = "/home/vagrant/project/docker-compose.yml"   # Path to your docker-compose.yml file
    destination = "/home/ubuntu/docker-compose.yml"

    connection {
      type        = "ssh"
      user        = "ubuntu"                    # Default user for Ubuntu instances
      private_key = file("../cloud1.cer")  # Replace with the path to your private key
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "/home/vagrant/project/nginx.conf"           # Path to your nginx.conf file
    destination = "/home/ubuntu/nginx.conf"

    connection {
      type        = "ssh"
      user        = "ubuntu"                    # Default user for Ubuntu instances
      private_key = file("../cloud1.cer")  # Replace with the path to your private key
      host        = self.public_ip
    }
  }

  # Remote exec provisioner with explicit connection block
    provisioner "remote-exec" {
    inline = [
      "echo 'Starting file transfer and setup...'",

      # "sudo mv /home/ubuntu/docker-compose.yml /root/docker-compose.yml || { echo 'Failed to move docker-compose.yml'; exit 1; }",
      # "sudo mv /home/ubuntu/nginx.conf /root/nginx.conf || { echo 'Failed to move nginx.conf'; exit 1; }",

      # "cd /root || { echo 'Failed to change directory to /root'; exit 1; }",
      "sudo /home/ubuntu/docker-compose up -d || { echo 'Failed to start Docker containers'; exit 1; }",

      "echo 'File transfer and setup completed successfully!'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../cloud1.cer")
      host        = self.public_ip
    }
  }

}

output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
