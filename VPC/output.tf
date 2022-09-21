output "VPC_ID" {
    value = "${module.dev.VPC_ID}"
}

output "Subnet1" {
  value = "${module.dev.Subnet1}"
}

output "Subnet2" {
  value = "${module.dev.Subnet2}"
}

output "Subnet3" {
  value = "${module.dev.Subnet3}"
}

output "Private_Subnet1" {
  value = "${module.dev.Private_Subnet1}"
}

output "Private_Subnet2" {
  value = "${module.dev.Private_Subnet2}"
}

output "Private_Subnet3" {
  value = "${module.dev.Private_Subnet3}"
}

output "IGW" {
    value = "${module.dev.IGW}"
}

output "dynamodb" {
  value = "${module.dev.dynamodb_table}"
}

output "NGW" {
    value = "${module.dev.ngw}"
}

output "sec_group_1" {
  value = "${module.dev.web_sec_group}"
}
output "sec_group_2" {
  value = "${module.dev.mysql_sec_group}"
}