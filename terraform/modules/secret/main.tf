/*
 * # Google Secret Manager Secret Module
 * This custom module is used to create a random password and store it to the google secret manager. The secret-id is
 * exposed as an output so to be passed on the other modules as input variable.
*/

data "google_project" "current" {}

# We create a random password
resource "random_password" "password" {
  length           = var.length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_id
  replication {
    automatic = true
  }
}
# Store the password in the secret manager
resource "google_secret_manager_secret_version" "secret-version-data" {
  secret = google_secret_manager_secret.secret.name
  secret_data = random_password.password.result
}

# The default compute service account is allowed to access the secret.
resource "google_secret_manager_secret_iam_member" "secret-access" {
  secret_id = google_secret_manager_secret.secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com"
  depends_on = [google_secret_manager_secret.secret]
}