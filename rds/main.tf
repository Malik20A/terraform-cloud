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



resource "aws_rds_cluster" "example" {
  cluster_identifier = "example"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = "test"
  master_username    = "test"
  master_password    = "must_be_eight_characters"
  db_subnet_group_name = aws_db_subnet_group.db.name

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "example1" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version
}


resource "aws_rds_cluster_instance" "example2" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version
}

resource "aws_rds_cluster_endpoint" "reader2" {
  cluster_identifier          = aws_rds_cluster.example.id
  cluster_endpoint_identifier = "reader2"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.example1.id
  ]
}

resource "aws_rds_cluster_endpoint" "reader3" {
  cluster_identifier          = aws_rds_cluster.example.id
  cluster_endpoint_identifier = "reader3"
  custom_endpoint_type        = "READER"

  excluded_members = [
    aws_rds_cluster_instance.example2.id
   ]
}

