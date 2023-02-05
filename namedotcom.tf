/*resource "namedotcom_domain_nameservers" "domain" {
  domain_name = var.domain_name
  nameservers = [
    data.aws_route53_zone.domain.name_servers[0],
    data.aws_route53_zone.domain.name_servers[1],
    data.aws_route53_zone.domain.name_servers[2],
    data.aws_route53_zone.domain.name_servers[3]
   ]
}*/
