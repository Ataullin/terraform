resource "google_artifact_registry_repository" "my_docker_repo" {
  location     = "us-central1"
  repository_id = "test-docker-repo"
  format       = "DOCKER"
  description  = "My Docker repository"
}

resource "google_artifact_registry_repository_iam_member" "artifact_viewer" {
  repository = google_artifact_registry_repository.my_docker_repo.id
  role       = "roles/artifactregistry.reader"
  member     = "user:example@example.com"
}