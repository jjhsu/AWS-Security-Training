//SNS to send the security alert to cloudwatch alarm

resource "aws_sns_topic" "security_alerts" {
  name         = "security-alerts-topic-${random_string.random_name.result}"
  display_name = "Security Alerts"
}

resource "aws_sns_topic_subscription" "security_alerts_to_sqs" {
  topic_arn = "${aws_sns_topic.security_alerts.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.security_alerts.arn}"
}

resource "aws_sqs_queue" "security_alerts" {
  name = "security-alerts-${random_string.random_name.result}"
}

resource "aws_sqs_queue_policy" "sns_to_sqs" {
  queue_url = "${aws_sqs_queue.security_alerts.id}"

  policy = <<EOF
{
"Version":"2012-10-17",
"Statement":[
  {
    "Effect":"Allow",
    "Principal":"*",
    "Action":"sqs:SendMessage",
    "Resource":"${aws_sqs_queue.security_alerts.arn}",
    "Condition":{
      "ArnEquals":{
        "aws:SourceArn":"${aws_sns_topic.security_alerts.arn}"
      }
    }
  }
]
}
EOF
}
