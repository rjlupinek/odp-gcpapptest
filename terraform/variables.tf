variable "region" {
  type = "string"
  default = "us-east1"
}

variable "environment" {
	type = "string"
}

variable "project_id" {
  type = "string"
}

variable "notification_email" {
  type = "string"
}

variable "cloudsql_db_name" {
  type = "string"
}

variable "cloudsql_username" {
  type = "string"
}

variable "cloudsql_password" {
  type = "string"
}
