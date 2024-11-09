provider "google" {
    credentials = file("/Users/r.ataullin/.config/gcloud/application_default_credentials.json")
    project     = "gcp-educative-project-cli-2024"
    region      = "us-central1"
}

resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "POSTGRES_15"

  settings {
    tier = "db-g1-small"
    disk_type   = "PD_HDD"
    disk_size   = 10
  }
}

resource "google_sql_database" "database" {
  name           = "url_shortener"
  instance       = google_sql_database_instance.instance.name
  deletion_policy = "ABANDON"

  depends_on = [google_sql_database_instance.instance]
}

resource "google_sql_user" "database_user" {
  name     = "admin"
  instance = google_sql_database_instance.instance.name
  password = "mypassword123"

  depends_on = [google_sql_database_instance.instance]
}