data "aws_subnet" "private" {
  id = "${var.private_subnet_id}"
}

data "aws_subnet" "public" {
  id = "${var.public_subnet_id}"
}

resource "aws_security_group" "server" {
  name_prefix = "${var.environment_name}-"
  vpc_id      = "${data.aws_subnet.private.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "client" {
  name_prefix = "${var.environment_name}-"
  vpc_id      = "${data.aws_subnet.public.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  count                  = "${var.server_count}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.server.id}"]
  subnet_id              = "${var.private_subnet_id}"

  tags {
    Name = "${var.environment_name}-server-${count.index + 1}"
  }
}

resource "aws_instance" "client" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.client.id}"]
  subnet_id              = "${var.public_subnet_id}"

  tags {
    Name = "${var.environment_name}-client"
  }
}
