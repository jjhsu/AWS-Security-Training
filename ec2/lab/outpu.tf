resource "local_file" "aws_key" {
  content = "${tls_private_key.test_key.private_key_pem}"
  filename = "aws_test.pem"
}

output "ec2_url" {
  value = "${aws_instance.wb.public_ip}"
}
