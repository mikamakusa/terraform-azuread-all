## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.53.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.53.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/terraform-azure-keyvault | n/a |

## Module Usage

### administrative Unit
#### Resources
```terraform
module "azuread" {
  source                          = "./modules/terraform-azure-keyvault"
  administrative_unit             = var.administrative_unit
  administrative_unit_role_member = var.administrative_unit_role_member
  user                            = var.user
}
```
#### variables
````terraform
variable "administrative_univ" {
  type = any
}

variable "administrative_unit_role_member" {
  type = any
}

variable "user" {
  type = any
}
````
#### .tfvars
````terraform
user = [{
  id                  = 0
  user_principal_name = "jdoe@hashicorp.com"
  display_name        = "J. Doe"
  mail_nickname       = "jdoe"
  password            = "SecretP@sswd99!"
}]
administrative_unit = [{
  id            = 0
  display_name  = "test"
}]
administrative_unit_role_member = [{
  id                            = 0
  administrative_unit_object_id = 0
  member_object_id              = 0
}]
````

#### resource relation graph
````mermaid
flowchart TD
%%Nodes
    A(User)
    B(Administrative_Unit)
    C(administrative_unit_role_member)
%% Connections
    A --> B --> C
````

### App Role Assignment
#### Resources
````terraform
module "azuread" {
  source                          = "./modules/terraform-azure-keyvault"
  app_role_assignment = var.app_role_assignment
  application         = var.application
  service_principal   = var.service_principal
}
````

#### Variables
````terraform
variable "app_role_assignment" {
  type = any
}

variable "application" {
  type = any
}

variable "service_principal" {
type = any
}
````

#### tfvars
````terraform
app_role_assignment = [
  {
      id                  = 0
      app_role_id         = 0
      principal_object_id = 1
      resource_object_id  = 0
    }
]
application = [{
  id               = 0
  display_name     = "example"
  identifier_uris  = ["api://example-app"]
  logo_image       = "logo.png"
  sign_in_audience = "AzureADMultipleOrgs"
  api = [
    {
      mapped_claims_enabled          = true
      requested_access_token_version = 2

      oauth2_permission_scope = [
        {
          admin_consent_description = "Allow the application to access example on behalf of the signed-in user."
          admin_consent_display_name = "Access example"
          enabled = true
          id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
          type = "User"
          user_consent_description = "Allow the application to access example on your behalf."
          user_consent_display_name = "Access example"
          value = "user_impersonation"
        }
      ]
      oauth2_permission_scope = [
        {
          admin_consent_description = "Administer the example application"
          admin_consent_display_name = "Administer"
          enabled = true
          id                         = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc"
          type = "Admin"
          value = "administer"
        }
      ]
    }
  ]
  app_role  = [
    {
      allowed_member_types = ["User", "Application"]
      description  = "Admins can manage roles and perform all task actions"
      display_name = "Admin"
      enabled      = true
      id           = "1b19509b-32b1-4e9f-b71d-4992aa991967"
      value        = "admin"
    }
  ]
  feature_tags = [
    {
      enterprise = true
      gallery    = true
    }
  ]
  optional_claims = [
    {
      access_token = [
        {
          name = "myclaim"
        }
      ]
      access_token = [
        {
          name = "otherclaim"
        }
      ]
      id_token = [
        {
          name      = "userclaim"
          source    = "user"
          essential = true
          additional_properties = ["emit_as_roles"]
        }
      ]
      saml2_token = [
        {
          name = "samlexample"
        }
      ]
    }
  ]
}]
service_principal = [
  {
      id        = 0
      client_id = 0
      feature_tags = [
        {
          enterprise = true
          gallery    = true
        }
      ]
    },
  {
    id        = 1
    client_id = 0
    feature_tags = [
      {
        enterprise = true
        gallery    = true
      }
    ]
  }
]
````

#### resource relation graph
````mermaid
flowchart TD
%%Nodes
    A(application)
    B(service_principal.A)
    D(service_principal.B)
    C(app_role_assignment)
%% Connections
    B --> A
    A --> D --> C
    B --> C
````

## Resources

| Name | Type |
|------|------|
| [azuread_access_package.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package) | resource |
| [azuread_access_package_assignment_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package_assignment_policy) | resource |
| [azuread_access_package_catalog.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package_catalog) | resource |
| [azuread_access_package_catalog_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package_catalog_role_assignment) | resource |
| [azuread_access_package_resource_catalog_association.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package_resource_catalog_association) | resource |
| [azuread_access_package_resource_package_association.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/access_package_resource_package_association) | resource |
| [azuread_administrative_unit.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/administrative_unit) | resource |
| [azuread_administrative_unit_member.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/administrative_unit_member) | resource |
| [azuread_administrative_unit_role_member.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/administrative_unit_role_member) | resource |
| [azuread_app_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/app_role_assignment) | resource |
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application) | resource |
| [azuread_application_api_access.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_api_access) | resource |
| [azuread_application_app_role.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_app_role) | resource |
| [azuread_application_certificate.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_certificate) | resource |
| [azuread_application_fallback_public_client.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_fallback_public_client) | resource |
| [azuread_application_federated_identity_credential.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_from_template.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_from_template) | resource |
| [azuread_application_identifier_uri.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_identifier_uri) | resource |
| [azuread_application_known_clients.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_known_clients) | resource |
| [azuread_application_optional_claims.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_optional_claims) | resource |
| [azuread_application_owner.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_owner) | resource |
| [azuread_application_password.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_password) | resource |
| [azuread_application_permission_scope.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_permission_scope) | resource |
| [azuread_application_pre_authorized.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_pre_authorized) | resource |
| [azuread_application_redirect_uris.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_redirect_uris) | resource |
| [azuread_application_registration.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/application_registration) | resource |
| [azuread_authentication_strength_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/authentication_strength_policy) | resource |
| [azuread_claims_mapping_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/claims_mapping_policy) | resource |
| [azuread_conditional_access_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/conditional_access_policy) | resource |
| [azuread_custom_directory_role.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/custom_directory_role) | resource |
| [azuread_directory_role.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role) | resource |
| [azuread_directory_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role_assignment) | resource |
| [azuread_directory_role_eligibility_schedule_request.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role_eligibility_schedule_request) | resource |
| [azuread_directory_role_member.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role_member) | resource |
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/group) | resource |
| [azuread_group_member.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/group_member) | resource |
| [azuread_group_role_management_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/group_role_management_policy) | resource |
| [azuread_invitation.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/invitation) | resource |
| [azuread_named_location.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/named_location) | resource |
| [azuread_privileged_access_group_assignment_schedule.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/privileged_access_group_assignment_schedule) | resource |
| [azuread_privileged_access_group_eligibility_schedule.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/privileged_access_group_eligibility_schedule) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal) | resource |
| [azuread_service_principal_certificate.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal_certificate) | resource |
| [azuread_service_principal_claims_mapping_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal_claims_mapping_policy_assignment) | resource |
| [azuread_service_principal_delegated_permission_grant.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal_delegated_permission_grant) | resource |
| [azuread_service_principal_password.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal_password) | resource |
| [azuread_service_principal_token_signing_certificate.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/service_principal_token_signing_certificate) | resource |
| [azuread_synchronization_job.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/synchronization_job) | resource |
| [azuread_synchronization_job_provision_on_demand.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/synchronization_job_provision_on_demand) | resource |
| [azuread_synchronization_secret.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/synchronization_secret) | resource |
| [azuread_user.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/user) | resource |
| [azuread_user_flow_attribute.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/user_flow_attribute) | resource |
| [azuread_access_package_catalog_role.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/access_package_catalog_role) | data source |
| [azuread_application_published_app_ids.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/application_published_app_ids) | data source |
| [azuread_application_template.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/application_template) | data source |
| [azuread_client_config.this](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_package"></a> [access\_package](#input\_access\_package) | n/a | <pre>list(object({<br>    id           = number<br>    catalog_id   = any<br>    description  = string<br>    display_name = string<br>    hidden       = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_access_package_assignment_policy"></a> [access\_package\_assignment\_policy](#input\_access\_package\_assignment\_policy) | n/a | <pre>list(object({<br>    id                = number<br>    access_package_id = any<br>    description       = string<br>    display_name      = string<br>    duration_in_days  = optional(number)<br>    expiration_date   = optional(string)<br>    extension_enabled = optional(bool)<br>    approval_settings = optional(list(object({<br>      approval_required                = optional(bool)<br>      approval_required_for_extension  = optional(bool)<br>      requestor_justification_required = optional(bool)<br>      approval_stage = optional(list(object({<br>        approval_timeout_in_days            = number<br>        alternative_approval_enabled        = optional(bool)<br>        approver_justification_required     = optional(bool)<br>        enable_alternative_approval_in_days = optional(number)<br>        alternative_approver = optional(list(object({<br>          subject_type = string<br>          backup       = optional(bool)<br>          object_id    = optional(any)<br>        })))<br>        primary_approver = optional(list(object({<br>          subject_type = string<br>          backup       = optional(bool)<br>          object_id    = optional(any)<br>        })))<br>      })))<br>    })))<br>    assignment_review_settings = optional(list(object({<br>      access_recommendation_enabled   = optional(bool)<br>      access_review_timeout_behavior  = optional(string)<br>      approver_justification_required = optional(bool)<br>      duration_in_days                = optional(number)<br>      enabled                         = optional(bool)<br>      review_frequency                = optional(string)<br>      review_type                     = optional(string)<br>      starting_on                     = optional(string)<br>      reviewer = optional(list(object({<br>        subject_type = string<br>        backup       = optional(bool)<br>        object_id    = optional(any)<br>      })))<br>    })))<br>    question = optional(list(object({<br>      required = optional(bool)<br>      sequence = optional(number)<br>      choice = optional(list(object({<br>        actual_value = string<br>        display_value = list(object({<br>          content       = string<br>          language_code = string<br>        }))<br>      })))<br>      text = list(object({<br>        default_text = string<br>        localized_text = list(object({<br>          content       = string<br>          language_code = string<br>        }))<br>      }))<br>    })))<br>    requestor_settings = optional(list(object({<br>      requests_accepted = optional(bool)<br>      scope_type        = optional(string)<br>      requestor = optional(list(object({<br>        subject_type = string<br>        object_id    = optional(any)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_access_package_catalog"></a> [access\_package\_catalog](#input\_access\_package\_catalog) | n/a | <pre>list(object({<br>    id                 = number<br>    description        = string<br>    display_name       = string<br>    externally_visible = optional(bool)<br>    published          = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_access_package_catalog_role_assignment"></a> [access\_package\_catalog\_role\_assignment](#input\_access\_package\_catalog\_role\_assignment) | n/a | <pre>list(object({<br>    id                  = number<br>    catalog_id          = any<br>    principal_object_id = any<br>    role_id             = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_access_package_resource_catalog_association"></a> [access\_package\_resource\_catalog\_association](#input\_access\_package\_resource\_catalog\_association) | n/a | <pre>list(object({<br>    id                     = number<br>    catalog_id             = any<br>    resource_origin_id     = any<br>    resource_origin_system = string<br>  }))</pre> | `[]` | no |
| <a name="input_access_package_resource_package_association"></a> [access\_package\_resource\_package\_association](#input\_access\_package\_resource\_package\_association) | n/a | <pre>list(object({<br>    id                              = number<br>    access_package_id               = any<br>    catalog_resource_association_id = any<br>    access_type                     = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_administrative_unit"></a> [administrative\_unit](#input\_administrative\_unit) | n/a | <pre>list(object({<br>    id                        = number<br>    display_name              = string<br>    description               = optional(string)<br>    hidden_membership_enabled = optional(bool)<br>    members                   = optional(set(string))<br>  }))</pre> | `[]` | no |
| <a name="input_administrative_unit_member"></a> [administrative\_unit\_member](#input\_administrative\_unit\_member) | n/a | <pre>list(object({<br>    id                            = number<br>    administrative_unit_object_id = optional(any)<br>    member_object_id              = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_administrative_unit_role_member"></a> [administrative\_unit\_role\_member](#input\_administrative\_unit\_role\_member) | n/a | <pre>list(object({<br>    id                            = number<br>    administrative_unit_object_id = optional(any)<br>    member_object_id              = optional(any)<br>    role_object_id                = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_app_role_assignment"></a> [app\_role\_assignment](#input\_app\_role\_assignment) | n/a | <pre>list(object({<br>    id                  = number<br>    app_role_id         = any<br>    principal_object_id = any<br>    resource_object_id  = any<br>  }))</pre> | `[]` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | <pre>list(object({<br>    id                             = number<br>    display_name                   = string<br>    description                    = optional(string)<br>    device_only_auth_enabled       = optional(bool)<br>    fallback_public_client_enabled = optional(bool)<br>    group_membership_claims        = optional(list(string))<br>    identifier_uris                = optional(list(string))<br>    logo_image                     = optional(string)<br>    marketing_url                  = optional(string)<br>    notes                          = optional(string)<br>    oauth2_post_response_required  = optional(bool)<br>    owners                         = optional(list(string))<br>    prevent_duplicate_names        = optional(bool)<br>    privacy_statement_url          = optional(string)<br>    service_management_reference   = optional(string)<br>    sign_in_audience               = optional(string)<br>    support_url                    = optional(string)<br>    tags                           = optional(list(string))<br>    template_id                    = optional(any)<br>    terms_of_service_url           = optional(string)<br>    password = optional(list(object({<br>      display_name = string<br>      start_date   = optional(string)<br>      end_date     = optional(string)<br>    })))<br>    api = optional(list(object({<br>      known_client_applications      = optional(list(string))<br>      mapped_claims_enabled          = optional(bool)<br>      requested_access_token_version = optional(number)<br>      oauth2_permission_scope = optional(list(object({<br>        id                         = optional(string)<br>        admin_consent_description  = optional(string)<br>        admin_consent_display_name = optional(string)<br>        enabled                    = optional(bool)<br>        type                       = optional(string)<br>        user_consent_description   = optional(string)<br>        user_consent_display_name  = optional(string)<br>        value                      = optional(string)<br>      })))<br>    })))<br>    app_role = optional(list(object({<br>      allowed_member_types = list(string)<br>      description          = string<br>      display_name         = string<br>      id                   = string<br>      enabled              = optional(bool)<br>      value                = optional(string)<br>    })))<br>    feature_tags = optional(list(object({<br>      custom_single_sign_on = optional(bool)<br>      enterprise            = optional(bool)<br>      gallery               = optional(bool)<br>      hide                  = optional(bool)<br>    })))<br>    optional_claims = optional(list(object({<br>      access_token = optional(list(object({<br>        name                  = string<br>        additional_properties = optional(list(string))<br>        essential             = optional(bool)<br>        source                = optional(string)<br>      })))<br>      id_token = optional(list(object({<br>        name                  = string<br>        additional_properties = optional(list(string))<br>        essential             = optional(bool)<br>        source                = optional(string)<br>      })))<br>      saml2_token = optional(list(object({<br>        name                  = string<br>        additional_properties = optional(list(string))<br>        essential             = optional(bool)<br>        source                = optional(string)<br>      })))<br>    })))<br>    public_client = optional(list(object({<br>      redirect_uris = optional(list(string))<br>    })))<br>    required_resource_access = optional(list(object({<br>      resource_app_id = string<br>      resource_access = optional(list(object({<br>        id   = string<br>        type = string<br>      })))<br>    })))<br>    single_page_application = optional(list(object({<br>      redirect_uris = optional(list(string))<br>    })))<br>    web = optional(list(object({<br>      homepage_url  = optional(string)<br>      logout_url    = optional(string)<br>      redirect_uris = optional(list(string))<br>      implicit_grant = optional(list(object({<br>        access_token_issuance_enabled = optional(bool)<br>        id_token_issuance_enabled     = optional(bool)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_application_api_access"></a> [application\_api\_access](#input\_application\_api\_access) | n/a | <pre>list(object({<br>    id             = number<br>    api_client_id  = any<br>    application_id = any<br>    role_ids       = optional(list(any))<br>    scope_ids      = optional(list(any))<br>  }))</pre> | `[]` | no |
| <a name="input_application_app_role"></a> [application\_app\_role](#input\_application\_app\_role) | n/a | <pre>list(object({<br>    id                   = number<br>    allowed_member_types = list(any)<br>    application_id       = any<br>    description          = string<br>    display_name         = string<br>    role_id              = any<br>    value                = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_application_certificate"></a> [application\_certificate](#input\_application\_certificate) | n/a | <pre>list(object({<br>    id             = number<br>    certificate_id = optional(any)<br>    value          = optional(string)<br>    application_id = any<br>    type           = string<br>    encoding       = string<br>    end_date       = optional(string)<br>    start_date     = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_application_fallback_public_client"></a> [application\_fallback\_public\_client](#input\_application\_fallback\_public\_client) | n/a | <pre>list(object({<br>    id             = number<br>    application_id = any<br>    enabled        = bool<br>  }))</pre> | `[]` | no |
| <a name="input_application_federated_identity_credential"></a> [application\_federated\_identity\_credential](#input\_application\_federated\_identity\_credential) | n/a | <pre>list(object({<br>    id             = number<br>    application_id = any<br>    display_name   = string<br>    description    = string<br>    audiences      = string<br>    issuer         = string<br>    subject        = string<br>  }))</pre> | `[]` | no |
| <a name="input_application_from_template"></a> [application\_from\_template](#input\_application\_from\_template) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = string<br>    template_id  = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_application_identifier_uri"></a> [application\_identifier\_uri](#input\_application\_identifier\_uri) | n/a | <pre>list(object({<br>    id             = number<br>    application_id = any<br>    identifier_uri = string<br>  }))</pre> | `[]` | no |
| <a name="input_application_known_clients"></a> [application\_known\_clients](#input\_application\_known\_clients) | n/a | <pre>list(object({<br>    id               = number<br>    application_id   = any<br>    known_client_ids = list(any)<br>  }))</pre> | `[]` | no |
| <a name="input_application_optional_claims"></a> [application\_optional\_claims](#input\_application\_optional\_claims) | n/a | <pre>list(object({<br>    id             = number<br>    application_id = any<br>    access_token = optional(list(object({<br>      name                  = string<br>      additional_properties = optional(list(string))<br>      essential             = optional(bool)<br>      source                = optional(string)<br>    })))<br>    id_token = optional(list(object({<br>      name                  = string<br>      additional_properties = optional(list(string))<br>      essential             = optional(bool)<br>      source                = optional(string)<br>    })))<br>    saml2_token = optional(list(object({<br>      name                  = string<br>      additional_properties = optional(list(string))<br>      essential             = optional(bool)<br>      source                = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_application_owner"></a> [application\_owner](#input\_application\_owner) | n/a | <pre>list(object({<br>    id              = number<br>    application_id  = any<br>    owner_object_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_application_password"></a> [application\_password](#input\_application\_password) | n/a | <pre>list(object({<br>    id                  = number<br>    application_id      = optional(any)<br>    display_name        = optional(string)<br>    end_date            = optional(string)<br>    end_date_relative   = optional(string)<br>    rotate_when_changed = optional(map(any))<br>    start_date          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_application_permission_scope"></a> [application\_permission\_scope](#input\_application\_permission\_scope) | n/a | <pre>list(object({<br>    id                         = number<br>    admin_consent_description  = string<br>    admin_consent_display_name = string<br>    application_id             = any<br>    scope_id                   = string<br>    value                      = string<br>    type                       = string<br>    user_consent_description   = string<br>    user_consent_display_name  = string<br>  }))</pre> | `[]` | no |
| <a name="input_application_pre_authorized"></a> [application\_pre\_authorized](#input\_application\_pre\_authorized) | n/a | <pre>list(object({<br>    id                   = number<br>    permission_ids       = list(any)<br>    application_id       = any<br>    authorized_client_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_application_redirect_uris"></a> [application\_redirect\_uris](#input\_application\_redirect\_uris) | n/a | <pre>list(object({<br>    id             = number<br>    application_id = any<br>    redirect_uris  = list(string)<br>    type           = string<br>  }))</pre> | `[]` | no |
| <a name="input_application_registration"></a> [application\_registration](#input\_application\_registration) | n/a | <pre>list(object({<br>    id                                     = number<br>    display_name                           = string<br>    description                            = optional(string)<br>    group_membership_claims                = optional(list(string))<br>    homepage_url                           = optional(string)<br>    implicit_access_token_issuance_enabled = optional(bool)<br>    implicit_id_token_issuance_enabled     = optional(bool)<br>    logout_url                             = optional(string)<br>    marketing_url                          = optional(string)<br>    notes                                  = optional(string)<br>    privacy_statement_url                  = optional(string)<br>    requested_access_token_version         = optional(number)<br>    service_management_reference           = optional(string)<br>    sign_in_audience                       = optional(string)<br>    support_url                            = optional(string)<br>    terms_of_service_url                   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_application_template_display_name"></a> [application\_template\_display\_name](#input\_application\_template\_display\_name) | n/a | `string` | `null` | no |
| <a name="input_authentication_strength_policy"></a> [authentication\_strength\_policy](#input\_authentication\_strength\_policy) | n/a | <pre>list(object({<br>    id                   = number<br>    allowed_combinations = list(string)<br>    display_name         = string<br>    description          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | n/a | `any` | n/a | yes |
| <a name="input_claims_mapping_policy"></a> [claims\_mapping\_policy](#input\_claims\_mapping\_policy) | n/a | <pre>list(object({<br>    id           = number<br>    definition   = list(string)<br>    display_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_conditional_access_policy"></a> [conditional\_access\_policy](#input\_conditional\_access\_policy) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = string<br>    state        = string<br>    conditions = optional(list(object({<br>      client_app_types              = list(string)<br>      service_principal_risk_levels = list(string)<br>      sign_in_risk_levels           = list(string)<br>      user_risk_levels              = list(string)<br>      applications = optional(list(object({<br>        excluded_applications = optional(list(string))<br>        included_applications = optional(list(string))<br>        included_user_actions = optional(list(string))<br>      })))<br>      client_applications = optional(list(object({<br>        excluded_service_principals = optional(list(string))<br>        included_service_principals = optional(list(string))<br>      })))<br>      devices = optional(list(object({<br>        filter = optional(list(object({<br>          mode = string<br>          rule = string<br>        })))<br>      })))<br>      locations = optional(list(object({<br>        included_locations = list(string)<br>        excluded_locations = optional(list(string))<br>      })))<br>      platforms = optional(list(object({<br>        included_platforms = list(string)<br>        excluded_platforms = optional(list(string))<br>      })))<br>      users = optional(list(object({<br>        excluded_groups = optional(list(string))<br>        excluded_roles  = optional(list(string))<br>        excluded_users  = optional(list(string))<br>        included_groups = optional(list(string))<br>        included_roles  = optional(list(string))<br>        included_users  = optional(list(string))<br>        excluded_guests_or_external_users = optional(list(object({<br>          guestçor_external_user_type = list(string)<br>          external_tenants = optional(list(object({<br>            membership_kind = string<br>            members         = optional(list(string))<br>          })))<br>        })))<br>        included_guests_or_external_users = optional(list(object({<br>          guestçor_external_user_type = list(string)<br>          external_tenants = optional(list(object({<br>            membership_kind = string<br>            members         = optional(list(string))<br>          })))<br>        })))<br>      })))<br>    })))<br>    grant_controls = optional(list(object({<br>      operator                          = string<br>      authentication_strength_policy_id = optional(string)<br>      built_in_controls                 = optional(list(string))<br>      custom_authentication_factors     = optional(list(string))<br>      terms_of_use                      = optional(list(string))<br>    })))<br>    session_controls = optional(list(object({<br>      application_enforced_restrictions_enabled = optional(bool)<br>      cloud_app_security_policy                 = optional(string)<br>      disable_resilience_defaults               = optional(bool)<br>      persistent_browser_mode                   = optional(string)<br>      sign_in_frequency                         = optional(number)<br>      sign_in_frequency_authentication_type     = optional(string)<br>      sign_in_frequency_interval                = optional(string)<br>      sign_in_frequency_period                  = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_custom_directory_role"></a> [custom\_directory\_role](#input\_custom\_directory\_role) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = string<br>    enabled      = bool<br>    version      = string<br>    description  = optional(string)<br>    template_id  = optional(string)<br>    permissions = list(object({<br>      allowed_resource_actions = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_directory_role"></a> [directory\_role](#input\_directory\_role) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = optional(string)<br>    template_id  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_directory_role_assignment"></a> [directory\_role\_assignment](#input\_directory\_role\_assignment) | n/a | <pre>list(object({<br>    id                  = number<br>    principal_object_id = any<br>    role_id             = any<br>    app_scope_id        = optional(any)<br>    application_id      = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_directory_role_eligibility_schedule_request"></a> [directory\_role\_eligibility\_schedule\_request](#input\_directory\_role\_eligibility\_schedule\_request) | n/a | <pre>list(object({<br>    id                 = number<br>    directory_scope_id = string<br>    justification      = string<br>    principal_id       = any<br>    role_definition_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_directory_role_member"></a> [directory\_role\_member](#input\_directory\_role\_member) | n/a | <pre>list(object({<br>    id               = number<br>    member_object_id = optional(any)<br>    role_object_id   = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_group"></a> [group](#input\_group) | n/a | <pre>list(object({<br>    id                         = number<br>    display_name               = string<br>    administrative_unit_ids    = optional(list(string))<br>    assignable_to_role         = optional(bool)<br>    auto_subscribe_new_members = optional(bool)<br>    behaviors                  = optional(list(string))<br>    description                = optional(string)<br>    external_senders_allowed   = optional(bool)<br>    hide_from_address_lists    = optional(bool)<br>    hide_from_outlook_clients  = optional(bool)<br>    mail_enabled               = optional(bool)<br>    mail_nickname              = optional(string)<br>    members                    = optional(list(any))<br>    onpremises_group_type      = optional(string)<br>    user_id                    = optional(list(any))<br>    prevent_duplicate_names    = optional(bool)<br>    provisioning_options       = optional(list(string))<br>    security_enabled           = optional(bool)<br>    theme                      = optional(string)<br>    types                      = optional(list(string))<br>    visibility                 = optional(string)<br>    writeback_enabled          = optional(bool)<br>    dynamic_membership = optional(list(object({<br>      enabled = bool<br>      role    = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_group_member"></a> [group\_member](#input\_group\_member) | n/a | <pre>list(object({<br>    id               = number<br>    group_object_id  = any<br>    member_object_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_group_role_management_policy"></a> [group\_role\_management\_policy](#input\_group\_role\_management\_policy) | n/a | <pre>list(object({<br>    id       = number<br>    group_id = any<br>    role_id  = string<br>    activation_rules = optional(list(object({<br>      maximum_duration                                   = optional(string)<br>      require_approval                                   = optional(bool)<br>      require_justification                              = optional(bool)<br>      require_multifactor_authentication                 = optional(bool)<br>      require_ticket_info                                = optional(bool)<br>      required_conditional_access_authentication_context = optional(string)<br>      approval_stage = optional(list(object({<br>        primary_approver = optional(list(object({<br>          object_id = any<br>          type      = optional(string)<br>        })))<br>      })))<br>    })))<br>    active_assignment_rules = optional(list(object({<br>      expiration_required                = optional(bool)<br>      expire_after                       = optional(string)<br>      require_justification              = optional(bool)<br>      require_multifactor_authentication = optional(bool)<br>      require_ticket_info                = optional(bool)<br>    })))<br>    eligible_assignment_rules = optional(list(object({<br>      expiration_required = optional(bool)<br>      expire_after        = optional(string)<br>    })))<br>    notification_rules = optional(list(object({<br>      active_assignments = optional(list(object({<br>        admin_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        approver_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        assignee_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>      })))<br>      eligible_activations = optional(list(object({<br>        admin_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        approver_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        assignee_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>      })))<br>      eligible_assignments = optional(list(object({<br>        admin_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        approver_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>        assignee_notifications = optional(list(object({<br>          default_recipients    = bool<br>          notification_level    = string<br>          additional_recipients = optional(list(string))<br>        })))<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_invitation"></a> [invitation](#input\_invitation) | n/a | <pre>list(object({<br>    id                 = number<br>    redirect_url       = string<br>    user_email_address = string<br>    user_display_name  = optional(string)<br>    user_type          = optional(string, "Guest")<br>    message = optional(list(object({<br>      additional_recipients = optional(string)<br>      body                  = optional(string)<br>      language              = optional(string, "en-US")<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | n/a | `any` | n/a | yes |
| <a name="input_named_location"></a> [named\_location](#input\_named\_location) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = string<br>    country = optional(list(object({<br>      countries_and_regions                 = list(string)<br>      include_unknown_countries_and_regions = optional(bool)<br>    })))<br>    ip = optional(list(object({<br>      ip_ranges = list(string)<br>      trusted   = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_privileged_access_group_assignment_schedule"></a> [privileged\_access\_group\_assignment\_schedule](#input\_privileged\_access\_group\_assignment\_schedule) | n/a | <pre>list(object({<br>    id                   = number<br>    assignment_type      = string<br>    group_id             = any<br>    user_id              = any<br>    justification        = optional(string)<br>    ticket_number        = optional(string)<br>    ticket_system        = optional(string)<br>    start_date           = optional(string)<br>    expiration_date      = optional(string)<br>    duration             = optional(string)<br>    permanent_assignment = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_privileged_access_group_eligibility_schedule"></a> [privileged\_access\_group\_eligibility\_schedule](#input\_privileged\_access\_group\_eligibility\_schedule) | n/a | <pre>list(object({<br>    id                   = number<br>    assignment_type      = string<br>    group_id             = any<br>    user_id              = any<br>    justification        = optional(string)<br>    ticket_number        = optional(string)<br>    ticket_system        = optional(string)<br>    start_date           = optional(string)<br>    expiration_date      = optional(string)<br>    duration             = optional(string)<br>    permanent_assignment = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | n/a | <pre>list(object({<br>    id                            = number<br>    account_enabled               = optional(bool)<br>    alternative_names             = optional(list(string))<br>    app_role_assignment_required  = optional(bool)<br>    client_id                     = optional(any)<br>    description                   = optional(string)<br>    login_url                     = optional(string)<br>    notes                         = optional(string)<br>    notification_email_addresses  = optional(list(string))<br>    owners                        = optional(list(string))<br>    preferred_single_sign_on_mode = optional(string)<br>    tags                          = optional(list(string))<br>    use_existing                  = optional(bool)<br>    feature_tags = optional(list(object({<br>      custom_single_sign_on = optional(bool)<br>      enterprise            = optional(bool)<br>      gallery               = optional(bool)<br>      hide                  = optional(bool)<br>    })))<br>    saml_single_sign_on = optional(list(object({<br>      relay_state = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_service_principal_certificate"></a> [service\_principal\_certificate](#input\_service\_principal\_certificate) | n/a | <pre>list(object({<br>    id                   = number<br>    service_principal_id = any<br>    value                = string<br>    encoding             = optional(string)<br>    end_date             = optional(string)<br>    end_date_relative    = optional(string)<br>    key_id               = optional(string)<br>    start_date           = optional(string)<br>    type                 = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_principal_claims_mapping_policy_assignment"></a> [service\_principal\_claims\_mapping\_policy\_assignment](#input\_service\_principal\_claims\_mapping\_policy\_assignment) | n/a | <pre>list(object({<br>    id                       = number<br>    claims_mapping_policy_id = any<br>    service_principal_id     = any<br>  }))</pre> | `[]` | no |
| <a name="input_service_principal_delegated_permission_grant"></a> [service\_principal\_delegated\_permission\_grant](#input\_service\_principal\_delegated\_permission\_grant) | n/a | <pre>list(object({<br>    id                   = number<br>    claim_values         = list(string)<br>    service_principal_id = any<br>    user_id              = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_service_principal_password"></a> [service\_principal\_password](#input\_service\_principal\_password) | n/a | <pre>list(object({<br>    id                   = number<br>    service_principal_id = any<br>    end_date             = optional(string)<br>    end_date_relative    = optional(string)<br>    rotate_when_changed  = optional(map(string))<br>    start_date           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_service_principal_token_signing_certificate"></a> [service\_principal\_token\_signing\_certificate](#input\_service\_principal\_token\_signing\_certificate) | n/a | <pre>list(object({<br>    id                   = number<br>    service_principal_id = any<br>    display_name         = optional(string)<br>    end_date             = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_synchronization_job"></a> [synchronization\_job](#input\_synchronization\_job) | n/a | <pre>list(object({<br>    id                   = number<br>    service_principal_id = any<br>    template_id          = string<br>    enabled              = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_synchronization_job_provision_on_demand"></a> [synchronization\_job\_provision\_on\_demand](#input\_synchronization\_job\_provision\_on\_demand) | n/a | <pre>list(object({<br>    id                     = number<br>    service_principal_id   = any<br>    synchronization_job_id = any<br>    triggers               = optional(string)<br>    parameter = list(object({<br>      rule_id = any<br>      subject = list(object({<br>        group_id         = any<br>        object_type_name = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_synchronization_secret"></a> [synchronization\_secret](#input\_synchronization\_secret) | n/a | <pre>list(object({<br>    id                   = number<br>    service_principal_id = any<br>    credential = list(object({<br>      key   = string<br>      value = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | n/a | <pre>list(object({<br>    id                          = number<br>    display_name                = string<br>    user_principal_name         = string<br>    account_enabled             = optional(bool)<br>    age_group                   = optional(string)<br>    business_phones             = optional(list(string))<br>    city                        = optional(string)<br>    company_name                = optional(string)<br>    consent_provided_for_minor  = optional(string)<br>    cost_center                 = optional(string)<br>    country                     = optional(string)<br>    department                  = optional(string)<br>    disable_password_expiration = optional(bool)<br>    disable_strong_password     = optional(bool)<br>    division                    = optional(string)<br>    employee_id                 = optional(string)<br>    employee_type               = optional(string)<br>    fax_number                  = optional(string)<br>    force_password_change       = optional(bool)<br>    given_name                  = optional(string)<br>    job_title                   = optional(string)<br>    mail                        = optional(string)<br>    mail_nickname               = optional(string)<br>    mobile_phone                = optional(string)<br>    office_location             = optional(string)<br>    onpremises_immutable_id     = optional(string)<br>    other_mails                 = optional(list(string))<br>    password                    = optional(string)<br>    postal_code                 = optional(string)<br>    preferred_language          = optional(string)<br>    show_in_address_list        = optional(bool)<br>    state                       = optional(string)<br>    street_address              = optional(string)<br>    surname                     = optional(string)<br>    usage_location              = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_user_flow_attribute"></a> [user\_flow\_attribute](#input\_user\_flow\_attribute) | n/a | <pre>list(object({<br>    id           = number<br>    data_type    = string<br>    description  = string<br>    display_name = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_package_assignment_policy_id"></a> [access\_package\_assignment\_policy\_id](#output\_access\_package\_assignment\_policy\_id) | n/a |
| <a name="output_access_package_catalog_id"></a> [access\_package\_catalog\_id](#output\_access\_package\_catalog\_id) | n/a |
| <a name="output_access_package_catalog_role_assignment_id"></a> [access\_package\_catalog\_role\_assignment\_id](#output\_access\_package\_catalog\_role\_assignment\_id) | n/a |
| <a name="output_access_package_id"></a> [access\_package\_id](#output\_access\_package\_id) | n/a |
| <a name="output_access_package_resource_catalog_association_id"></a> [access\_package\_resource\_catalog\_association\_id](#output\_access\_package\_resource\_catalog\_association\_id) | n/a |
| <a name="output_access_package_resource_package_association_id"></a> [access\_package\_resource\_package\_association\_id](#output\_access\_package\_resource\_package\_association\_id) | n/a |
| <a name="output_administrative_unit_display_name"></a> [administrative\_unit\_display\_name](#output\_administrative\_unit\_display\_name) | n/a |
| <a name="output_administrative_unit_id"></a> [administrative\_unit\_id](#output\_administrative\_unit\_id) | n/a |
| <a name="output_administrative_unit_member_id"></a> [administrative\_unit\_member\_id](#output\_administrative\_unit\_member\_id) | n/a |
| <a name="output_administrative_unit_object_id"></a> [administrative\_unit\_object\_id](#output\_administrative\_unit\_object\_id) | n/a |
| <a name="output_administrative_unit_role_member_id"></a> [administrative\_unit\_role\_member\_id](#output\_administrative\_unit\_role\_member\_id) | n/a |
| <a name="output_application_app_role_display_name"></a> [application\_app\_role\_display\_name](#output\_application\_app\_role\_display\_name) | n/a |
| <a name="output_application_app_role_id"></a> [application\_app\_role\_id](#output\_application\_app\_role\_id) | n/a |
| <a name="output_application_certificate_id"></a> [application\_certificate\_id](#output\_application\_certificate\_id) | n/a |
| <a name="output_application_display_name"></a> [application\_display\_name](#output\_application\_display\_name) | n/a |
| <a name="output_application_fallback_public_client_id"></a> [application\_fallback\_public\_client\_id](#output\_application\_fallback\_public\_client\_id) | n/a |
| <a name="output_application_federated_identity_credential_credential_id"></a> [application\_federated\_identity\_credential\_credential\_id](#output\_application\_federated\_identity\_credential\_credential\_id) | n/a |
| <a name="output_application_federated_identity_credential_id"></a> [application\_federated\_identity\_credential\_id](#output\_application\_federated\_identity\_credential\_id) | n/a |
| <a name="output_application_from_template_display_name"></a> [application\_from\_template\_display\_name](#output\_application\_from\_template\_display\_name) | n/a |
| <a name="output_application_from_template_id"></a> [application\_from\_template\_id](#output\_application\_from\_template\_id) | n/a |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | n/a |
| <a name="output_application_identifier_uri_id"></a> [application\_identifier\_uri\_id](#output\_application\_identifier\_uri\_id) | n/a |
| <a name="output_application_known_clients_id"></a> [application\_known\_clients\_id](#output\_application\_known\_clients\_id) | n/a |
| <a name="output_application_optional_claims_id"></a> [application\_optional\_claims\_id](#output\_application\_optional\_claims\_id) | n/a |
| <a name="output_application_owner_id"></a> [application\_owner\_id](#output\_application\_owner\_id) | n/a |
| <a name="output_application_password_id"></a> [application\_password\_id](#output\_application\_password\_id) | n/a |
| <a name="output_application_permission_scope_id"></a> [application\_permission\_scope\_id](#output\_application\_permission\_scope\_id) | n/a |
| <a name="output_application_redirect_uris_id"></a> [application\_redirect\_uris\_id](#output\_application\_redirect\_uris\_id) | n/a |
| <a name="output_application_registration_id"></a> [application\_registration\_id](#output\_application\_registration\_id) | n/a |
| <a name="output_authentication_strength_policy_id"></a> [authentication\_strength\_policy\_id](#output\_authentication\_strength\_policy\_id) | n/a |
| <a name="output_claims_mapping_policy_id"></a> [claims\_mapping\_policy\_id](#output\_claims\_mapping\_policy\_id) | n/a |
| <a name="output_conditional_access_policy_display_name"></a> [conditional\_access\_policy\_display\_name](#output\_conditional\_access\_policy\_display\_name) | n/a |
| <a name="output_conditional_access_policy_id"></a> [conditional\_access\_policy\_id](#output\_conditional\_access\_policy\_id) | n/a |
| <a name="output_custom_directory_role_id"></a> [custom\_directory\_role\_id](#output\_custom\_directory\_role\_id) | n/a |
| <a name="output_directory_role_assignment_id"></a> [directory\_role\_assignment\_id](#output\_directory\_role\_assignment\_id) | n/a |
| <a name="output_directory_role_eligibility_schedule_request_id"></a> [directory\_role\_eligibility\_schedule\_request\_id](#output\_directory\_role\_eligibility\_schedule\_request\_id) | n/a |
| <a name="output_directory_role_id"></a> [directory\_role\_id](#output\_directory\_role\_id) | n/a |
| <a name="output_directory_role_member_id"></a> [directory\_role\_member\_id](#output\_directory\_role\_member\_id) | n/a |
| <a name="output_directory_role_object_id"></a> [directory\_role\_object\_id](#output\_directory\_role\_object\_id) | n/a |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | n/a |
| <a name="output_group_member_id"></a> [group\_member\_id](#output\_group\_member\_id) | n/a |
| <a name="output_group_role_management_policy_id"></a> [group\_role\_management\_policy\_id](#output\_group\_role\_management\_policy\_id) | n/a |
| <a name="output_invitation_id"></a> [invitation\_id](#output\_invitation\_id) | n/a |
| <a name="output_named_location_id"></a> [named\_location\_id](#output\_named\_location\_id) | n/a |
| <a name="output_privileged_access_group_assignment_schedule_id"></a> [privileged\_access\_group\_assignment\_schedule\_id](#output\_privileged\_access\_group\_assignment\_schedule\_id) | n/a |
| <a name="output_privileged_access_group_eligibility_schedule_id"></a> [privileged\_access\_group\_eligibility\_schedule\_id](#output\_privileged\_access\_group\_eligibility\_schedule\_id) | n/a |
| <a name="output_service_principal_app_roles"></a> [service\_principal\_app\_roles](#output\_service\_principal\_app\_roles) | n/a |
| <a name="output_service_principal_certificate_id"></a> [service\_principal\_certificate\_id](#output\_service\_principal\_certificate\_id) | n/a |
| <a name="output_service_principal_claims_mapping_policy_assignment_id"></a> [service\_principal\_claims\_mapping\_policy\_assignment\_id](#output\_service\_principal\_claims\_mapping\_policy\_assignment\_id) | n/a |
| <a name="output_service_principal_delegated_permission_grant_id"></a> [service\_principal\_delegated\_permission\_grant\_id](#output\_service\_principal\_delegated\_permission\_grant\_id) | n/a |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | n/a |
| <a name="output_service_principal_password"></a> [service\_principal\_password](#output\_service\_principal\_password) | n/a |
| <a name="output_service_principal_permission_scopes"></a> [service\_principal\_permission\_scopes](#output\_service\_principal\_permission\_scopes) | n/a |
| <a name="output_service_principal_token_signing_certificate"></a> [service\_principal\_token\_signing\_certificate](#output\_service\_principal\_token\_signing\_certificate) | n/a |
| <a name="output_synchronization_job"></a> [synchronization\_job](#output\_synchronization\_job) | n/a |
| <a name="output_synchronization_job_provision_on_demand"></a> [synchronization\_job\_provision\_on\_demand](#output\_synchronization\_job\_provision\_on\_demand) | n/a |
| <a name="output_synchronization_secret"></a> [synchronization\_secret](#output\_synchronization\_secret) | n/a |
| <a name="output_user"></a> [user](#output\_user) | n/a |
| <a name="output_user_flow_attribute"></a> [user\_flow\_attribute](#output\_user\_flow\_attribute) | n/a |
