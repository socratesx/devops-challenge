# First step is to create the VPC, Subnets & VPC Access connector for serverless access
module "application_network" {
  source       = "./modules/network"
  region       = var.region
  network_name = "net1"
  application_subnet_name = "app-subnet"
  vpc_connector_subnet_name   = "connect-subnet"
}

# Next we create a random password and we store it in the secret manager
module "db_secret" {
  source    = "./modules/secret"
  secret_id = "db_password"
}

# We continue by creating a docker artifact repository and pushing there our containerized application
module "app_image" {
  source        = "./modules/container_registry"
  region        = var.region
  repository_id = "db-health-checker"
  app_version = var.app_version
}

# The application needs a database to work. The following module is provisioning a compute instance that run a postgres
# container for our database simulation.
module "database" {
  source = "./modules/container_compute_instance"
  container_image = "postgres:13-alpine"
  instance_name = "database"
  region = var.region
  container_environment = [
    {
      name = "POSTGRES_PASSWORD"
      value = module.db_secret.secret # We are passing the secret data directly to the env var value.
    }
  ]
  subnetwork_name = module.application_network.application_subnet_name # We are using the output value to enforce implicit dependency, that is for terraform to create this module after the application_network.
  providers = {
    google = google-beta
  }
  container_port = 5432
}

# Finally The application module deploys our application in Google cloud run.
module "app1" {
  source = "./modules/cloudrun_service"

  container_port = 8080
  image_url      = module.app_image.container_image  # Using the output from the app_image module to pass the url of our application container
  name           = "app1"
  region         = var.region
  revision       = var.app_version
  environment = [
    {
      name  = "POSTGRESQL_HOST"
      value = module.database.endpoint # This is taken from the database module output, to ensure that this module will initialized after database.
    },

    {
      name  = "POSTGRESQL_PORT"
      value = "5432"
    },

    {
      name  = "POSTGRESQL_USER"
      value = "postgres"
    },

    {
      name  = "POSTGRESQL_DBNAME"
      value = "postgres"
    },
    {
      name = "POSTGRESQL_PASSWORD"
      secret_id = "db_password" # This is a reference to a secret in secret-manager. We are not passing/exposing the secret data. The module uses this id to get the secret from secret manager.
    }
  ]
  liveness_probe = {
    probe_type = "http_get"
    path = "/health"
  }
  connector_id = module.application_network.connector_id # The following connector is used to allow connectivity with our database instance in the application subnet.
  depends_on = [module.app_image]
}

