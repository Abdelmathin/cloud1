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
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-west-2a"  # Replace with your desired AZ
    map_public_ip_on_launch = true
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
    instance_type = "t2.2xlarge"             # Free tier eligible instance type
    subnet_id     = aws_subnet.public.id     # Place the instance in the public subnet

    key_name      = "cloud1"                 # Replace with your actual key pair name

    vpc_security_group_ids = [aws_security_group.web.id]  # Attach the security group using vpc_security_group_ids

    tags = {
        Name = "inception-web-server"
    }
    user_data = file("scripts/run.sh")
}