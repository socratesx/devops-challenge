output "endpoint" {
  description = "This output contains the IP address of the compute instance"
  value = google_compute_instance.vm.network_interface[0].network_ip
}