provider "aws" {
  region     = "us-east-1"
}

resource "tls_private_key" "ucsf_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ucsf_aws_lynis"
  public_key = "${tls_private_key.ucsf_test_key.public_key_openssh}"
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.ucsf_test_key.private_key_pem}"
  filename = "aws_test.pem"
}


resource "aws_security_group" "allow_ssh" {
  name        = "lynis-ssh-vpc"
  description = "Allow all ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name   = "${aws_key_pair.generated_key.key_name}"
  security_groups = [
  	"${aws_security_group.allow_ssh.name}"
  ]
  provisioner "remote-exec" {
  	connection {
  		type = "ssh"
  		user = "ubuntu"
  		private_key = "${tls_private_key.ucsf_test_key.private_key_pem}"
  		host = "${aws_instance.web.public_ip}"
  	}
  	inline = [
      "sudo apt-get update && sudo apt install -y lynis && sudo lynis audit system --quick > /tmp/lynis-report.txt"
  	]
  }
  provisioner "local-exec" {
    command = "chmod 400 ${local_file.aws_key.filename} && scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${local_file.aws_key.filename} ubuntu@${aws_instance.web.public_ip}:/tmp/lynis-report.txt $(pwd)"
  }
}







