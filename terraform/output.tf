output "outbound_url" {
  value = aws_ssm_parameter.outbound_url.value
}

output "inbound_url" {
  value = aws_ssm_parameter.inbound_url.value
}

output "route_url" {
  value = aws_ssm_parameter.route_url.value
}

variable "deductions_env" {
  default = "dev" #FIXME: just use same env name, requires new certs
}

resource "aws_ssm_parameter" "outbound_url" {
  name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/mhs-${var.deductions_env}/outbound_url"
  type  = "String"
  value = trimsuffix("https://mhs-outbound.${aws_route53_zone.mhs_hosted_zone.name}", ".")
}

resource "aws_ssm_parameter" "inbound_url" {
  name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/mhs-${var.deductions_env}/inbound_url"
  type  = "String"
  value = trimsuffix("https://mhs-inbound.${aws_route53_zone.mhs_hosted_zone.name}", ".")
}

resource "aws_ssm_parameter" "route_url" {
  name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/mhs-${var.deductions_env}/route_url"
  type  = "String"
  value = trimsuffix("https://mhs-route.${aws_route53_zone.mhs_hosted_zone.name}", ".")
}
