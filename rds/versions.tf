terraform {
  backend "remote" {
    organization = "Malik20A"

    workspaces {
      name = "wordpress_db_test"
    }
  }
}
