variable "gcp_project" {
  description = "The GCP project ID."
  default     = "sfeir-school-terraform"
}

variable "instance_name" {
  description = "The name of the instance."
  default     = "dvoets"
}

variable "username" {
  description = "The name of the user."
  default     = "dvoets"
}

variable "region" {
  description = "The region the instance will sit in."
  default     = "europe-west1"
}

variable "database_version" {
  description = "The MySQL or PostgreSQL version to use."
  default     = "MYSQL_5_7"
}

