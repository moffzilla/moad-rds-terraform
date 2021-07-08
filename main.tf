terraform {
  required_version = "~> 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  database_name           = "opencart"
  master_username         = "ocuser"
  master_password         = var.db_password
  port = "3306"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  cluster_identifier_prefix = "moad-tf"
  vpc_security_group_ids =  "sg-bf0c04dd"
  skip_final_snapshot  = true

  tags = {
    Cost Center = var.cost_center
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  publicly_accessible =  false

  tags = {
    Cost Center = var.cost_center
  }

}

