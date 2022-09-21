# resource "random_password" "random" {
#   length           = 32
#   special          = false
#   override_special = "!#$%&*()-_=+[]{}<>:?"
#   upper            = false
# }



# data "aws_availability_zones" "all" {}


# output "AZ" {
# 	value = data.aws_availability_zones.all.names
# }




# resource "aws_default_subnet" "default_az1" {
# 	availability_zone = data.aws_availability_zones.all.names[0]
# 	tags = {
# 		Name = "Subnet1"
# 	}
# }
# resource "aws_default_subnet" "default_az2" {
# 	availability_zone = data.aws_availability_zones.all.names[1]
# 	tags = {
# 		Name = "Subnet2"
# 	}
# }
# resource "aws_default_subnet" "default_az3" {
# 	availability_zone = data.aws_availability_zones.all.names[2]
# 	tags = {
# 		Name = "Subnet3"
# 	}
# }

# output "subnet1" {
# 	value = [ 
# 		aws_default_subnet.default_az1.id,
# 		aws_default_subnet.default_az2.id,
# 		aws_default_subnet.default_az3.id,
# 	]
# }

module "VPC" {
  source = "../VPC/module" 

resource "aws_subnet" "dev_private1" { 
  vpc_id = "${aws_vpc.dev.id}" 
  cidr_block = "${var.cidr_block1_private}"
  availability_zone = "${var.az1}"
} 

resource "aws_subnet" "dev_private2" { 
  vpc_id = "${aws_vpc.dev.id}" 
  cidr_block = "${var.cidr_block2_private}"
  availability_zone = "${var.az2}"
} 

resource "aws_subnet" "dev_private3" { 
  vpc_id = "${aws_vpc.dev.id}" 
  cidr_block = "${var.cidr_block3_private}"
  availability_zone = "${var.az3}"
}

  
}


 resource "aws_db_subnet_group" "db" {
 	name = "db"
 	subnet_ids = [
 		aws_subnet.dev_private1.id,
 		aws_subnet.dev_private2.id,
 		aws_subnet.dev_private3.id,
 	]
}


### DATA BASE CLUSTER WITH ONE READER, THREE READERS ###


resource "aws_rds_cluster" "wordpress_db" {
  cluster_identifier                      = "${var.cluster_identifier}"
  engine                                  = "${var.engine}"
  engine_mode                             = "${var.engine_mode}"
  engine_version                          = "${var.engine_version}"
  database_name                           = "${var.database_name}"
  master_username                         = "${var.master_username}"
  master_password                         = "${var.master_password}"
  db_subnet_group_name                    = "${aws_db_subnet_group.db.name}"
  skip_final_snapshot                     = "${var.skip_final_snapshot}"
  backup_retention_period                 = "${var.backup_retention_period}"
  preferred_backup_window                 = "${var.preferred_backup_window}"
  serverlessv2_scaling_configuration {
    max_capacity                          = "${var.max_capacity}"
    min_capacity                          = "${var.min_capacity}"
  }
}

resource "aws_rds_cluster_instance" "reader3" {
  cluster_identifier = aws_rds_cluster.wordpress_db.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.wordpress_db.engine
  engine_version     = aws_rds_cluster.wordpress_db.engine_version
}


resource "aws_rds_cluster_instance" "reader2" {
  cluster_identifier = aws_rds_cluster.wordpress_db.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.wordpress_db.engine
  engine_version     = aws_rds_cluster.wordpress_db.engine_version
}

resource "aws_rds_cluster_instance" "reader1" {
  cluster_identifier = aws_rds_cluster.wordpress_db.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.wordpress_db.engine
  engine_version     = aws_rds_cluster.wordpress_db.engine_version
}

resource "aws_rds_cluster_instance" "writer" {
  cluster_identifier = aws_rds_cluster.wordpress_db.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.wordpress_db.engine
  engine_version     = aws_rds_cluster.wordpress_db.engine_version
}


###  Do we need custom endpoints? ###



# resource "aws_rds_cluster_endpoint" "reader3" {
#   cluster_identifier          = aws_rds_cluster.wordpress_db.id
#   cluster_endpoint_identifier = "reader3"
#   custom_endpoint_type        = "READER"

#   excluded_members = [
#     aws_rds_cluster_instance.writer.id,
#     aws_rds_cluster_instance.reader2.id,
#     aws_rds_cluster_instance.reader1.id,
#   ]
# }

# resource "aws_rds_cluster_endpoint" "reader2" {
#   cluster_identifier          = aws_rds_cluster.wordpress_db.id
#   cluster_endpoint_identifier = "reader2"
#   custom_endpoint_type        = "READER"

#   excluded_members = [
#     aws_rds_cluster_instance.writer.id,
#     aws_rds_cluster_instance.reader1.id,
#     aws_rds_cluster_instance.reader3.id,

#    ]
# }

# resource "aws_rds_cluster_endpoint" "reader1" {
#   cluster_identifier          = aws_rds_cluster.wordpress_db.id
#   cluster_endpoint_identifier = "reader1"
#   custom_endpoint_type        = "READER"

#   excluded_members = [
#     aws_rds_cluster_instance.writer.id,
#     aws_rds_cluster_instance.reader2.id,
#     aws_rds_cluster_instance.reader3.id,
#   ]
# }

# resource "aws_rds_cluster_endpoint" "writer" {
#   cluster_identifier          = aws_rds_cluster.wordpress_db.id
#   cluster_endpoint_identifier = "writer"
#   custom_endpoint_type        = "ANY"

#   excluded_members = [
#     aws_rds_cluster_instance.reader1.id,
#     aws_rds_cluster_instance.reader2.id,
#     aws_rds_cluster_instance.reader3.id,
#    ]
# }


