# This is my public resource created in AWS GovCloud. I need this to be resolvable on the public internet
resource "aws_lb" "public" {
  name               = "bwelch-public-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  # Won't work out of the box
  subnets = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true
}

resource "aws_lb" "private" {
  name               = "bwelch-private-lb-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  # Won't work out of the box
  subnets = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
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

  tags = {
    Name = "allow_tls"
  }
}

data "aws_vpcs" "main" {
  name = var.vpc_name
}