variable "region" {
  type = "string"
  default = "us-east1"
}

  
variable "cloudsql_tier" {
  type = "string"
  default = "db-f1-micro"

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
