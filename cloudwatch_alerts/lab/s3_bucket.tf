//Setup S3 bucket to store logs from cloudtrail

resource "aws_s3_bucket" "cloud_trail_log_bucket" {
  bucket_prefix = "${var.bucket_prefix}"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "cloud_trail_log_bucket_policy" {
  bucket = "${aws_s3_bucket.cloud_trail_log_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow bucket ACL check",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "cloudtrail.amazonaws.com",
          "lambda.amazonaws.com"
          ]
        },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.cloud_trail_log_bucket.arn}"
    },
    {
      "Sid": "Allow bucket write",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "cloudtrail.amazonaws.com"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.cloud_trail_log_bucket.arn}/*",
      "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
    },
    {
      "Sid": "Allow bucket write for lambda",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.cloud_trail_log_bucket.arn}/*"
    }

  ]
}
POLICY
}
