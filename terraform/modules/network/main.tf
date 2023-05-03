/*
 * # Google Application Network Module
 * This custom module is used to create a VPC and two subnetworks. The first subnet is used to deploy the database instance.
 * The second subnet is a /28 for the vpc access connector. The connector is used from cloud run service so it can reach
 * the database instance.
 *
 * The module also deploys the connector and exposes the connector_id as an output, to be used in cloud run service definitions.
*/

resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "application" {
  name                     = var.application_subnet_name
  ip_cidr_range            = var.application_subnet_cidr
  network                  = google_compute_network.main.self_link
  region                   = var.region
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "serverless_access" {
  name                     = var.vpc_connector_subnet_name
  ip_cidr_range            = var.vpc_connector_subnet_cidr
  network                  = google_compute_network.main.self_link
  region                   = var.region
  private_ip_google_access = true
}

resource "google_vpc_access_connector" "connector" {
  name = "serverless-vpc-connector"
  subnet {
    name = google_compute_subnetwork.serverless_access.name
  }
  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3
  region        = var.region
}
