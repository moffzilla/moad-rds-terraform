variable "cost_center" {
  description = "Specific Cost Center"
  default     = "Engineering"
}
variable "db_password" {
  description = "Default DB Password"
}

variable "region" {
  description = "The region Terraform deploys your RDS"
  default     = "us-east-1"
}
