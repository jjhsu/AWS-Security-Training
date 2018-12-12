resource "aws_security_group" "internet_ssh" {
  name = "internet_ssh"
  description = "Allow incoming SSH access for Bastion Host from Internet"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Internet -> Bastion SSH + Egress ALL"
  }
}

resource "aws_security_group" "internet_http" {
  name = "internet_http"
  description = "Allow incoming HTTP connections to Web Server from the Internet"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Internet -> WebServer HTTP + Egress ALL"
  }
}

resource "aws_security_group" "public_private_redis_ssh" {
  name = "Public-private-redis-ssh-${random_string.random_name.result}"
  description = "Allow access to Redis and SSH from Public Subnet TO Private Subnet"
  ingress {
    from_port = 6379
    protocol = "tcp"
    to_port = 6379
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Public -> Private Redis and SSH"
  }

}

resource "aws_security_group" "private_egress_http_https" {
  name = "Private Egress - ${random_string.random_name.result}"
  description = "Allow access to HTTP and HTTPS from private subnet"
  egress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Egress DB -> Internet HTTP/HTTPS"
  }
}
