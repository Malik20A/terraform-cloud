output "writer_aws_rds_endpoint" {
  value = "Writer ${aws_rds_cluster.example.endpoint}"
}

output "reader1_aws_rds_endpoint1" {
  value = "Reader ${aws_rds_cluster.example.reader_endpoint}"
}


output "reader2_aws_rds_endpoint" {
  value = "reader2 ${aws_rds_cluster_endpoint.reader2}"
}

output "reader3_aws_rds_endpoint" {
  value = "reader3 ${aws_rds_cluster_endpoint.reader3}"
}

