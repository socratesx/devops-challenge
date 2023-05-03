<!-- BEGIN_TF_DOCS -->
# Google Application Network Module
This custom module is used to create a VPC and two subnetworks. The first subnet is used to deploy the database instance.
The second subnet is a /28 for the vpc access connector. The connector is used from cloud run service so it can reach
the database instance.

The module also deploys the connector and exposes the connector\_id as an output, to be used in cloud run service definitions.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.application](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.serverless_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_vpc_access_connector.connector](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vpc_access_connector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_subnet_cidr"></a> [application\_subnet\_cidr](#input\_application\_subnet\_cidr) | The cidr range to assign to the application subnet | `string` | `"10.96.0.0/20"` | no |
| <a name="input_application_subnet_name"></a> [application\_subnet\_name](#input\_application\_subnet\_name) | The name of the application subnet | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The GCP network name to create | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to create the network | `string` | n/a | yes |
| <a name="input_vpc_connector_subnet_cidr"></a> [vpc\_connector\_subnet\_cidr](#input\_vpc\_connector\_subnet\_cidr) | The cidr range to assign to the vpc serverless connector subnet | `string` | `"10.8.0.0/28"` | no |
| <a name="input_vpc_connector_subnet_name"></a> [vpc\_connector\_subnet\_name](#input\_vpc\_connector\_subnet\_name) | The name of the vpc serverless connector subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_subnet_name"></a> [application\_subnet\_name](#output\_application\_subnet\_name) | The application subnet name |
| <a name="output_connector_id"></a> [connector\_id](#output\_connector\_id) | The VCP access connector id |
| <a name="output_connector_subnet_name"></a> [connector\_subnet\_name](#output\_connector\_subnet\_name) | The VPC access connector, subnet name |
<!-- END_TF_DOCS -->