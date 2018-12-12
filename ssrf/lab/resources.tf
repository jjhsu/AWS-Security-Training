# Define SSH key pair for our instances

resource "random_string" "random_name" {
  length = 10
  special = false
  upper = false
}

resource "tls_private_key" "we45_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}--${random_string.random_name.result}"
  public_key = "${tls_private_key.we45_test_key.public_key_openssh}"
}


resource "aws_instance" "wb" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.securtiy_group.id}" ]
  associate_public_ip_address = true
  source_dest_check = false
  tags {
    Name = "flask-app-${random_string.random_name.result}"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    agent = false
    private_key = "${tls_private_key.we45_test_key.private_key_pem}"
    timeout = "10m"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }


}
