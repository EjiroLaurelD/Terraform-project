/*resource "aws_launch_template" "terraform-ec2" {
  name                 = "terraform-asg"
  image_id             = lookup(var.amis, var.region)
#  image_id = var.amis
  instance_type        = "t2.micro"
  key_name             = var.key_name
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform"
    }t
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terraform-asg" {
  vpc_zone_identifier  = [for azs in aws_subnet.public-subnet: azs.id]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 3
  target_group_arns = toset([aws_lb_target_group.terraform-tg.arn])

  launch_template {
    id      = aws_launch_template.terraform-ec2.id
    version = "$Latest"

  }
}



## Creating AutoScaling Group
/*resource "aws_autoscaling_group" "terrafor-asg" {
    name = "terraform-asg"
    launch_configuration = aws_launch_configuration.ec2_launch_template.id
    availability_zones = "${data.aws_availability_zones.all.names}"
    min_size = 3
    max_size = 3
    load_balancers = aws_lb.terraform-alb.security_groups
    health_check_type = "ELB"
    termination_policies = ["oldest-instance"]
    tag {
      key = "Name"
      value = "terraform-asg"
      propagate_at_launch = true
    }
}*/








