resource "random_password" "random" {
  length           = 32
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = false
}



data "aws_availability_zones" "all" {}


output "AZ" {
	value = data.aws_availability_zones.all.names
}




resource "aws_default_subnet" "default_az1" {
	availability_zone = data.aws_availability_zones.all.names[0]
	tags = {
		Name = "Subnet1"
	}
}
resource "aws_default_subnet" "default_az2" {
	availability_zone = data.aws_availability_zones.all.names[1]
	tags = {
		Name = "Subnet2"
	}
}
resource "aws_default_subnet" "default_az3" {
	availability_zone = data.aws_availability_zones.all.names[2]
	tags = {
		Name = "Subnet3"
	}
}

output "subnet1" {
	value = [ 
		aws_default_subnet.default_az1.id,
		aws_default_subnet.default_az2.id,
		aws_default_subnet.default_az3.id,
	]
}


 resource "aws_db_subnet_group" "db" {
 	name = "db"
 	subnet_ids = [
 		aws_default_subnet.default_az1.id,
 		aws_default_subnet.default_az2.id,
 		aws_default_subnet.default_az3.id,
 	]
}


resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  database_name           = "mydb"
  master_username    = "test"
  master_password    = "must_be_eight_characters"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name = aws_db_subnet_group.db.name
  skip_final_snapshot = true
}


resource "aws_rds_cluster_instance" "reader1" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test1"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_instance" "reader2" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test2"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_instance" "reader3" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test3"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_instance" "writer" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "test3"
  instance_class     = "db.t2.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster_endpoint" "reader1" {
  cluster_identifier          = aws_rds_cluster.default.id
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.reader2.id,
    aws_rds_cluster_instance.reader3.id,
    aws_rds_cluster_instance.writer.id,
  ]
}

resource "aws_rds_cluster_endpoint" "reader2" {
  cluster_identifier          = aws_rds_cluster.default.id
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.reader1.id,
    aws_rds_cluster_instance.reader3.id,
    aws_rds_cluster_instance.writer.id,

  ]
}

resource "aws_rds_cluster_endpoint" "reader3" {
  cluster_identifier          = aws_rds_cluster.default.id
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.reader1.id,
    aws_rds_cluster_instance.reader2.id,
    aws_rds_cluster_instance.writer.id,

  ]
}

resource "aws_rds_cluster_endpoint" "writer" {
  cluster_identifier          = aws_rds_cluster.default.id
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.reader1.id,
    aws_rds_cluster_instance.reader2.id,
    aws_rds_cluster_instance.reader3.id,
  ]
}