/*
 * # Google Container Instance Custom Module
 * This custom module can deploy a single compute instance for running a container. In this exercise context, it was used
 * for deploying a postgres database container. This will play the role of our database that the go application will target.
 *
 * The module has enough parameters to be used for other use cases (out of scope for this exercise).
 *
 * The VM is using a container optimized image for running the database container.
 * The module is using another google module from the terraform registry that eases the process of the deployment.
*/

data "google_compute_zones" "zones" {
  region = var.region
}

# Return a random integer between 0 and the total number of available zones. This number is used as index for picking up
# a zone from the available zones list.
resource "random_integer" "zone_index" {
  min = 0
  max = length(data.google_compute_zones.zones.names) - 1
}

# We are calling the following third-party module to create the configuration object for the compute instance.
module "gce-container" {
  source = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  cos_image_name = var.cos_image_name

  container = {
    image          = var.container_image
    env            = var.container_environment
    volumeMounts   = var.container_volume_mounts
    volumes        = var.container_volumes
    restart_policy = var.container_restart_policy
  }
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  # We are picking up a zone randomly based on the index number returned by the random_integer resource.
  zone         = data.google_compute_zones.zones.names[random_integer.zone_index.result]

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    subnetwork         = var.subnetwork_name
    access_config {}
  }

  # We use the instance name as tag. This is used in the firewall rule to open up access
  tags = [var.instance_name]

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
    google-logging-enabled    = "false"
    google-monitoring-enabled = "true"
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

}

# Getting information for the subnet of the instance.
data google_compute_subnetwork "subnet" {
  self_link = google_compute_instance.vm.network_interface[0].subnetwork
}

# The following firewall rule allows access from the local subnet to the instance's container port
resource "google_compute_firewall" "allow-local-network" {
  name    = "${var.instance_name}-allow-internal-access"
  network = data.google_compute_subnetwork.subnet.network
  allow {
    protocol = "tcp"
    ports = [
      var.container_port
    ]
  }
  source_ranges = [data.google_compute_subnetwork.subnet.ip_cidr_range]
  target_tags = [var.instance_name]
}