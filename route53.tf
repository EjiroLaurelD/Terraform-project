/*data "aws_route53_zone" "selected" {
  name         = "test.com."
  private_zone = true
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.0.0.1"]
}*/
data "aws_route53_zone" "hosted-zone" {
  name         = "ejirolaureld.live"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "terraform-test.${data.aws_route53_zone.hosted-zone.name}"
  type    = "A"
  #ttl     = "300"
  #records = ["4"]
  #resource_record_set_count = 4
  alias {
    name = aws_lb.terraform-alb.dns_name
    zone_id = aws_lb.terraform-alb.zone_id
    evaluate_target_health = true
  }
}

