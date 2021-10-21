
variable "region" {
  default = "us-east-2"
}

variable "prefix" {
  default = "telegraph-rudderstack"
}

variable "ec2" {
  type = map(string)

  default = {
    "ami"              = "ami-0e5e17317f99b2932"
    "instance_type"    = "t3.small"
    "private_key_path" = "~/.ssh/id_rsa_tf"
  }
}
variable "s3_destination" {
  default = "telegraph-rudder-client-s3-destination"
}

variable "custom_vpc" {
  type = map(string)

  default = {
    vpc_id    = "vpc-0b40d4474e5cccd7c"
    subnet_id = "subnet-0b18c384db566fe54"
  }
}
