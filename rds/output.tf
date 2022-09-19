output "writer_aws_rds_endpoint" {
  value = "Writer ${aws_rds_cluster.example.endpoint}"
}

output "reader_aws_rds_endpoint1" {
  value = "Reader ${aws_rds_cluster.example.reader_endpoint}"
}


output "reader_aws_rds_endpoint2" {
  value = "reader2 ${aws_rds_cluster_endpoint.reader2}"
}

output "reader_aws_rds_endpoint3" {
  value = "reader3 ${aws_rds_cluster_endpoint.reader3}"
}

