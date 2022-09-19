output "writer_aws_rds_endpoint" {
  value = "Writer ${aws_rds_cluster.example.endpoint}"
}

output "reader1_aws_rds_endpoint1" {
  value = "Reader ${aws_rds_cluster.example.reader_endpoint}"
}


