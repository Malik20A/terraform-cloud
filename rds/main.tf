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



resource "aws_rds_cluster" "ex0" {
  cluster_identifier = "ex0"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = "test"
  master_username    = "test"
  master_password    = "must_be_eight_characters"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db.name

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "ex1" {
  cluster_identifier = aws_rds_cluster.ex0.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.ex0.engine
  engine_version     = aws_rds_cluster.ex0.engine_version
}

resource "aws_rds_cluster_instance" "ex2" {
  cluster_identifier = aws_rds_cluster.ex0.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.ex0.engine
  engine_version     = aws_rds_cluster.ex0.engine_version
}

resource "aws_rds_cluster_instance" "ex3" {
  cluster_identifier = aws_rds_cluster.ex0.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.ex0.engine
  engine_version     = aws_rds_cluster.ex0.engine_version
}
