# We are exposing as output the actual password. This wouldn't be the case in a real world scenario as it poses a security
# risk. However in the context of this exercise, we are doing it just to pass the secret in the database module input.
# As the database is out of scope, the following "compromise" should be treated as such.
output "secret" {
  description = "The actual password"
  value = google_secret_manager_secret_version.secret-version-data.secret_data
  sensitive = true
}

output "secret_id" {
  description = "The secret id"
  value = google_secret_manager_secret.secret.secret_id
}