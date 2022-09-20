namespace                                   = "wordpress_db"
region                                      = "us-east-1"
db_subnet_group_name                        = "mysql"
cluster_identifier                          = "mysql-wordpress"
engine                                      = "aurora"
engine_mode                                 = "provisioned"
engine_version                              = "5.6.10a"
serverlessv2_scaling_configuration {
    max_capacity                            = "1.0"
    min_capacity                            = "0.5"
  }
database_name                               = "wordpress_db"
master_username                             = ""
master_password                             = ""
backup_retention_period                     = 7
skip_final_snapshot                         = true
preferred_backup_window                     = "07:00-09:00"
tags                                        = {
    terraform   = "true"
    environment = "dev"
}                                                

