provider "aws" {
    region = "us-west-2"
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
    availability_zone       = "us-west-2a"
    map_public_ip_on_launch = true
    tags = {
        Name = "inception-public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-west-2a"
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
        from_port   = 443
        to_port     = 443
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
    ami           = "ami-02c41ffdfd4172736"  # 20.04 LTS
    instance_type = "t3.2xlarge"
    subnet_id     = aws_subnet.public.id

    key_name      = "cloud1"

    vpc_security_group_ids = [aws_security_group.web.id]

    tags = {
        Name = "cloud1-ahabachi"
    }
    
    user_data = file("scripts/aws-ubuntu-infrastructure.sh")
}

resource "aws_eip" "web_eip" {
    domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
    instance_id   = aws_instance.web.id
    allocation_id = "eipalloc-04fa7680b796f3d4e"
}
