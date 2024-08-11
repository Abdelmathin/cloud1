provider "aws" {
    profile = "default"
    region  = "u-east-1"
}

resource "aws_instance" "my_app" {
    ami           = "ami-007868005aea67c54" # amazon linux 2
    instance_type = "t2.micro"

    tags = {
        Name = "MyTerraformInstance"
    }
}
