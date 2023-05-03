<!-- BEGIN_TF_DOCS -->
# Google Container Instance Custom Module
This custom module can deploy a single compute instance for running a container. In this exercise context, it was used
for deploying a postgres database container. This will play the role of our database that the go application will target.

The module has enough parameters to be used for other use cases (out of scope for this exercise).

The VM is using a container optimized image for running the database container.
The module is using another google module from the terraform registry that eases the process of the deployment.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gce-container"></a> [gce-container](#module\_gce-container) | terraform-google-modules/container-vm/google | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow-local-network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [random_integer.zone_index](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_compute_zones.zones](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_environment"></a> [container\_environment](#input\_container\_environment) | A list of env vars to include in the container | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The container image to run in the VM | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port the running container listens to | `number` | n/a | yes |
| <a name="input_container_restart_policy"></a> [container\_restart\_policy](#input\_container\_restart\_policy) | The container restart policy | `string` | `"always"` | no |
| <a name="input_container_volume_mounts"></a> [container\_volume\_mounts](#input\_container\_volume\_mounts) | A list of volume mounts to include in the container declaration | <pre>list(object({<br>    mountPath = string<br>    name      = string<br>    readOnly  = bool<br>  }))</pre> | `[]` | no |
| <a name="input_container_volumes"></a> [container\_volumes](#input\_container\_volumes) | A list of volumes to attach in the container | <pre>list(object({<br>    name = string<br>    hostPath = optional(object({<br>      path = string<br>    }))<br>    memory = optional(object({<br>      medium = string<br>    }))<br>    gcePersistentDisk = optional(object({<br>      pdName = string<br>      fsType = string<br>    }))<br>    readOnly = bool<br>  }))</pre> | `[]` | no |
| <a name="input_cos_image_name"></a> [cos\_image\_name](#input\_cos\_image\_name) | The COS image to use. If not specified it uses the latest | `any` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The desired name to assign to the deployed instance | `any` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type of the compute instance | `string` | `"e2-micro"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the compute instance | `any` | n/a | yes |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | The name of the subnetwork to deploy the instance | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | This output contains the IP address of the compute instance |
<!-- END_TF_DOCS -->