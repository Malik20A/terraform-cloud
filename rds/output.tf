output "region" {
  region = "${var.region}"
}

output "database_name" {
  value = "${var.database_name}"
}

output "writer_aws_rds_endpoint" {
  value = "Writer ${aws_rds_cluster.example.endpoint}"
}

output "reader1_aws_rds_endpoint" {
  value = "Reader1 ${aws_rds_cluster.example.reader_endpoint}"
}

output "reader2_aws_rds_endpoint" {
  value = "Reader2 ${aws_rds_cluster.example.reader_endpoint}"
}


output "reader3_aws_rds_endpoint" {
  value = "Reader3 ${aws_rds_cluster.example.reader_endpoint}"
}




