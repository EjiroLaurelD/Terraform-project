## Security Group for ELB
resource "aws_security_group" "alb-sg" {
  name   = "terraformalb"
  vpc_id = aws_vpc.altschool-terraform.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  dynamic "ingress" {
    for_each = local.elb-rules
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
#Creating ELB

resource "aws_lb" "terraform-alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [for subnet in aws_subnet.public-subnet : subnet.id]
  # subnets = aws_subnet.public-subnet.*.id
}


resource "aws_lb_target_group" "terraform-tg" {
  name     = "terraform"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.altschool-terraform.id
  health_check {
    port = 80
    protocol = "HTTP"
    path = "/"
    matcher = "200-299"
  }
}

resource "aws_lb_listener" "terraform" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  #count = length(var.vpc-public-subnets)
  port            = "443"
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-1:605653682163:certificate/0323079b-bd22-418c-8c0c-a733846602d2"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-tg.arn

  } 
}
resource "aws_lb_listener" "http-https" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_target_group_attachment" "terraform-tg" {
  for_each = aws_instance.web
  target_group_arn = aws_lb_target_group.terraform-tg.arn
  target_id = each.value.id
  port = 80
}
