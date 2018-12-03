//role for allow cloudtrail to send data into cloudwatch

resource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "cloudtrail_policy"
  role = "${aws_iam_role.cloudtrail_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailCreateLogStream2014110",
      "Effect": "Allow",
      "Action": ["logs:CreateLogStream"],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "AWSCloudTrailPutLogEvents20141101",
      "Effect": "Allow",
      "Action": ["logs:PutLogEvents"],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
