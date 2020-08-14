provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

## Creating VPC "vpc_devops"
resource "aws_vpc" "vpc_devops" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

  tags = {
    Name = "vpc_devops"
  }
}

## Subnet Creation
resource "aws_subnet" "sub_public_devops" {
  vpc_id     = "${aws_vpc.vpc_devops.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "sub_public_devops"
  }
}

## Internet Gateway creation
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = "${aws_vpc.vpc_devops.id}"

  tags = {
    Name = "devops_igw"
  }
}

## Security group
resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.vpc_devops.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "sg_devops"
  }
}

## Key pair
resource "aws_key_pair" "kp_devops" {
  key_name   = "kp_devops"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAmk/YVYUk2cMPBE/1NqeyoUWIZFhE5Tmk9Y6xFR+ICef/IyfRayBj99wXGoGR5OvkXo1hXQgaVaWzWyZXl6frhPwCVVrw7IYyewcNq2y3sFbhVlwsPx+uxSN8xSq3/rbyRR0kipp+y+heuE5xAVugljbqU1hCojyh68iK2ZBQCIkqAsw4ikZlhQQbTLregJrwC7bKlTC8wV2m6OThOGGPTewBehSBfkxd1zJPtuQ2j6tYbWzOz93kc0CLGd7h3iUrBpsq8drat2nd1E93i25FydFd69xBdPah6UUsQrZPhhQPb+t5go9Imp19AJCk5gtG2VbmbK3swSyjYrPGtSWh2Q== rsa-key-20200723"
}

# Creating EC2 instance "ec2_devops" 
resource "aws_instance" "ec2_devops" {
  ami           = "ami-0e9089763828757e1"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.sub_public_devops.id}"
  key_name = "kp_devops"
  vpc_security_group_ids = ["${aws_security_group.sg_devops.id}"]

  tags = {
      Name = "ec2_devops"
  }
}

## Attaching Static IP
resource "aws_eip" "eip_devops" {
  vpc = true
  instance                  = "${aws_instance.ec2_devops.id}"
  depends_on                = ["aws_internet_gateway.devops_igw"]
}