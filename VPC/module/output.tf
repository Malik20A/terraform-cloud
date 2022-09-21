output "VPC_ID" {
    value = "${aws_vpc.dev.id}"
}

output "Subnet1" {
  value = "${aws_subnet.dev1.id}"
}

output "Subnet2" {
  value = "${aws_subnet.dev2.id}"
}

output "Subnet3" {
  value = "${aws_subnet.dev3.id}"
}

output "Private_Subnet1" {
  value = "${aws_subnet.dev_private1.id}"
}

output "Private_Subnet2" {
  value = "${aws_subnet.dev_private2.id}"
}

output "Private_Subnet3" {
  value = "${aws_subnet.dev_private3.id}"
}

output "IGW" {
    value = "${aws_internet_gateway.dev.id}"
}

# output "dynamodb_table" {
#   value = "terraform-team1"
# }

output "ngw" {
    value = "${aws_nat_gateway.nat_gw.id}"
}

output "web_sec_group" {
  value = "${aws_security_group.web_sec_group.id}"
}

output "mysql_sec_group" {
  value = "${aws_security_group.mysql_sec_group.id}"
}
