terraform {
  required_version = "1.3.9"
  required_providers {
    aws = "~> 4.66.1"
    template = "~> 2.2.0"
  }
}

data "aws_ami" "sdc" {
  filter {
    name   = "name"
    values = ["cdo-connector*"]
  }

  filter {
    name   = "tag:version"
    values = [var.ami_version]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["692314432491"]

  most_recent = true
}

resource "aws_security_group" "sdc" {
  vpc_id      = var.vpc_id
  name        = "${var.env}-${var.instance_name}-sdc-sg"
  description = "Security Group that allows all egress to the internet on TCP port 443"

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.env}-${var.instance_name}-sec-sg"
  }, var.tags)
}

data "template_file" "bootstrap" {
  template = file("${path.module}/bootstrap_sdc.tpl")
  vars = {
    cdo_bootstrap_data = var.cdo_bootstrap_data
  }
}

resource "aws_instance" "sdc" {
  ami                  = data.aws_ami.sdc.id
  instance_type        = var.instance_size
  tags = merge({
    Name = "${var.env}-${var.instance_name}-sdc"
  }, var.tags)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sdc.id]
  user_data              = data.template_file.bootstrap.rendered
}
