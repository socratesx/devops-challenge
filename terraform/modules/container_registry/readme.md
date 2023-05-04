<!-- BEGIN_TF_DOCS -->
# Google Container Registry Module
This custom module is used to create a docker-type artifact registry, build and push a container to that registry.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.app_repo](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [null_resource.image_push](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_service_account_access_token.access_token](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_access_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | The application version/tag to push to the registry | `string` | n/a | yes |
| <a name="input_application_code"></a> [application\_code](#input\_application\_code) | The application code path in this repository | `string` | `"../test-app"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to use for the artifact registry location | `string` | n/a | yes |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | The last part of the repository name | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account that will be used to push the container to the artifact registry | `string` | `"svc-terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_image"></a> [container\_image](#output\_container\_image) | The full url of the container image in the registry |
<!-- END_TF_DOCS -->