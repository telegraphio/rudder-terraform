
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
