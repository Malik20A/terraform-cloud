terraform {
backend "s3" {
bucket = "tastybucket2022"
key = "tower/us-east-1/tools/virginia/tower.tfstate"
region = "us-east-1"
  }
}
