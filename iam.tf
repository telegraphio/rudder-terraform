resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.prefix}_ec2_profile_name"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.prefix}_ec2_iam_role_name"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
  role       = "${aws_iam_role.ec2_role.name}"
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "${var.prefix}_ec2_iam_policy_name"
  description = "IAM policy for EC2 instance"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Put*"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
EOF
}
