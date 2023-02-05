output "instance_ids" {
  value = ["${aws_instance.web.*}"]
}
output "elb_dns_name" {
  value = aws_lb.terraform-alb.dns_name
}
