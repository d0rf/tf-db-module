resource "random_password" "password" {
  // Create a new password with special chars and 16 characters
  length  = 16
  special = true
}

resource "google_sql_database_instance" "master" {
  // Create a new sql database with variables.tf content
  project             = var.gcp_project
  name                = var.instance_name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = "false"
  // We allow internet access only for lab purpose
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "internet"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_user" "users" {
  // Create the database user
  project  = var.gcp_project
  name     = var.username
  instance = google_sql_database_instance.master.name
  password = random_password.password.result
}

resource "vault_generic_secret" "example" {
  // Put the password in vault
  path = "secret/${google_sql_user.users.name}"
  //data_json = jsonencode(random_password.password)
  data_json = <<EOT
{
  "user":   "${google_sql_user.users.name}",
  "password":   "${random_password.password.result}"
}
EOT
}
