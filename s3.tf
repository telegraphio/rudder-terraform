resource "aws_s3_bucket" "s3_destination" {
  bucket = var.s3_destination
  acl    = "private"
}
