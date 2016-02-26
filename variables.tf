variable "aws_region" {
  default = "us-east-1"
}

variable "token" {}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-7f3a0b15"
    us-west-2 = "ami-4f00e32f"
    us-west-1 = "ami-a8aedfc8"
  }
}

variable "inbound_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  default = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}

variable "instance_type" {
  default = "t2.medium"
  description = "AWS instance type"
}

variable "key_name" {
  description = "SSH keypair name to use on instances"
}

provider "aws" {
  region = "${var.aws_region}"
}
