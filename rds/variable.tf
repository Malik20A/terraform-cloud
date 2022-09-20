variable "region" {}

variable "cluster_identifier" {}

variable "engine" {}

variable "engine_mode" {}

variable "engine_version" {}

variable "max_capacity" {}

variable "min_capacity" {}

variable "database_name" {}

variable "master_username" {}

variable "master_password" {}

variable "backup_retention_period" {}

variable "preferred_backup_window" {}

variable "skip_final_snapshot" {}

variable "db_subnet_group_name" {}

# variable "vpc_security_group_ids" {}

variable "tags" {
  type = map
}