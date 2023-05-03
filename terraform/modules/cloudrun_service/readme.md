<!-- BEGIN_TF_DOCS -->
# Google Cloud Run Service Custom Module
This custom module can deploy a simple service in Google Cloud Run. It provides a simple output with the cloud run
service endpoint.

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
| [google_cloud_run_v2_service.service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connector_id"></a> [connector\_id](#input\_connector\_id) | The id of the vpc access connector. If skipped then the service is not deployed in a specific vpc | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port where the application is running | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | A list of environment variable definitions to include in the container | <pre>list(object({<br>    name      = string           # The name of the env var<br>    value     = optional(string) # The value of the env var, plain text<br>    secret_id = optional(string) # The env var value can be sourced by a secret_id in secrets manager<br>  }))</pre> | `[]` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | The full url of the container image to use | `string` | n/a | yes |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | The ingress type for the cloud run service | `string` | `"INGRESS_TRAFFIC_ALL"` | no |
| <a name="input_liveness_probe"></a> [liveness\_probe](#input\_liveness\_probe) | Liveness probe configuration object. If skipped it will use grpc defaults. | <pre>object({<br>    probe_type = string           # Can be http_get or grpc<br>    path       = optional(string) # used only when http_get is specified. defaults to "/"<br>    port       = optional(number) # used if grpc to specify the port to check. defaults to container_port<br>  })</pre> | <pre>{<br>  "probe_type": "grpc"<br>}</pre> | no |
| <a name="input_max_instance_count"></a> [max\_instance\_count](#input\_max\_instance\_count) | Maximum number of instances | `number` | `4` | no |
| <a name="input_min_instance_count"></a> [min\_instance\_count](#input\_min\_instance\_count) | Minimum number of instances | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cloud run service to run | `string` | n/a | yes |
| <a name="input_port_name"></a> [port\_name](#input\_port\_name) | The name of the container port | `string` | `"http1"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to run the container | `string` | n/a | yes |
| <a name="input_revision"></a> [revision](#input\_revision) | The name of the revision | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | This output contains the service endpoint. |
<!-- END_TF_DOCS -->