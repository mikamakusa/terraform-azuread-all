resource "azuread_administrative_unit" "this" {
  count                     = length(var.administrative_unit)
  display_name              = lookup(var.administrative_unit[count.index], "display_name")
  description               = lookup(var.administrative_unit[count.index], "description")
  hidden_membership_enabled = lookup(var.administrative_unit[count.index], "hidden_membership_enabled")
  members                   = lookup(var.administrative_unit[count.index], "members")
}

resource "azuread_administrative_unit_member" "this" {
  count                         = (length(var.administrative_unit) && length(var.user)) == 0 ? 0 : length(var.administrative_unit_member)
  administrative_unit_object_id = try(element(azuread_administrative_unit.this.*.id, lookup(var.administrative_unit_member[count.index], "administrative_unit_object_id")))
  member_object_id              = try(element(azuread_user.this.*.id, lookup(var.administrative_unit_member[count.index], "member_object_id")))
}

resource "azuread_administrative_unit_role_member" "this" {
  count                         = (length(var.administrative_unit) && length(var.directory_role) && length(var.user)) == 0 ? 0 : length(var.administrative_unit_role_member)
  administrative_unit_object_id = try(element(azuread_administrative_unit.this.*.id, lookup(var.administrative_unit_role_member[count.index], "administrative_unit_object_id")))
  member_object_id              = try(element(azuread_user.this.*.id, lookup(var.administrative_unit_role_member[count.index], "member_object_id")))
  role_object_id                = try(element(azuread_directory_role.this.*.id, lookup(var.administrative_unit_role_member[count.index], "role_object_id")))
}

resource "azuread_app_role_assignment" "this" {
  app_role_id         = ""
  principal_object_id = ""
  resource_object_id  = ""
}

resource "azuread_application" "this" {
  display_name = ""
}

resource "azuread_application_api_access" "this" {
  api_client_id  = ""
  application_id = azuread_application_registration.this.id
}

resource "azuread_application_app_role" "this" {
  allowed_member_types = []
  application_id       = azuread_application_registration.this.id
  description          = ""
  display_name         = ""
  role_id              = ""
}

resource "azuread_application_certificate" "this" {
  value = ""
}

resource "azuread_application_fallback_public_client" "this" {
  application_id = azuread_application_registration.this.id
  enabled        = true
}

resource "azuread_application_federated_identity_credential" "this" {
  application_id = azuread_application_registration.this.id
  display_name   = "my-repo-deploy"
  description    = "Deployments for my-repo"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:my-organization/my-repo:environment:prod"
}

resource "azuread_application_from_template" "this" {
  display_name = "this Application"
  template_id  = data.azuread_application_template.this.template_id
}

resource "azuread_application_identifier_uri" "this" {
  application_id = azuread_application_registration.this.id
  identifier_uri = "https://app.hashitown.com"
}

resource "azuread_application_known_clients" "this" {
  application_id = azuread_application_registration.this.id
  known_client_ids = [
    azuread_application_registration.this.client_id,
  ]
}

resource "azuread_application_optional_claims" "this" {
  application_id = ""
}

resource "azuread_application_owner" "this" {
  application_id  = ""
  owner_object_id = ""
}

resource "azuread_application_password" "this" {}

resource "azuread_application_permission_scope" "this" {
  admin_consent_description  = ""
  admin_consent_display_name = ""
  application_id             = ""
  scope_id                   = ""
  value                      = ""
}

resource "azuread_application_pre_authorized" "this" {
  permission_ids = []
}

resource "azuread_application_redirect_uris" "this" {
  application_id = ""
  redirect_uris  = []
  type           = ""
}

resource "azuread_application_registration" "this" {
  display_name = ""
}

resource "azuread_conditional_access_policy" "this" {
  display_name = ""
  state        = ""
}

resource "azuread_named_location" "this" {
  display_name = ""
}

resource "azuread_service_principal_delegated_permission_grant" "this" {
  claim_values                         = []
  resource_service_principal_object_id = ""
  service_principal_object_id          = ""
}

resource "azuread_custom_directory_role" "this" {
  display_name = ""
  enabled      = false
  version      = ""
}

resource "azuread_directory_role" "this" {}

resource "azuread_directory_role_assignment" "this" {
  principal_object_id = ""
  role_id             = ""
}

resource "azuread_directory_role_eligibility_schedule_request" "this" {
  directory_scope_id = ""
  justification      = ""
  principal_id       = ""
  role_definition_id = ""
}

resource "azuread_directory_role_member" "this" {}

resource "azuread_group" "this" {
  display_name = ""
}

resource "azuread_group_member" "this" {
  group_object_id  = ""
  member_object_id = ""
}

resource "azuread_access_package" "this" {
  catalog_id   = ""
  description  = ""
  display_name = ""
}

resource "azuread_access_package_assignment_policy" "this" {
  access_package_id = ""
  description       = ""
  display_name      = ""
}

resource "azuread_access_package_catalog" "this" {
  description  = ""
  display_name = ""
}

resource "azuread_access_package_catalog_role_assignment" "this" {
  catalog_id          = ""
  principal_object_id = ""
  role_id             = ""
}

resource "azuread_access_package_resource_catalog_association" "this" {
  catalog_id             = ""
  resource_origin_id     = ""
  resource_origin_system = ""
}

resource "azuread_access_package_resource_package_association" "this" {
  access_package_id               = ""
  catalog_resource_association_id = ""
}

resource "azuread_privileged_access_group_assignment_schedule" "this" {
  assignment_type = ""
  group_id        = ""
  principal_id    = ""
}

resource "azuread_privileged_access_group_eligibility_schedule" "this" {
  assignment_type = ""
  group_id        = ""
  principal_id    = ""
}

resource "azuread_invitation" "this" {
  redirect_url       = ""
  user_email_address = ""
}

resource "azuread_service_principal" "this" {}

resource "azuread_service_principal_certificate" "this" {
  service_principal_id = ""
  value                = ""
}

resource "azuread_service_principal_claims_mapping_policy_assignment" "this" {
  claims_mapping_policy_id = ""
  service_principal_id     = ""
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = ""
}

resource "azuread_service_principal_token_signing_certificate" "this" {
  service_principal_id = ""
}

resource "azuread_synchronization_job" "this" {
  service_principal_id = ""
  template_id          = ""
}

resource "azuread_synchronization_job_provision_on_demand" "this" {
  service_principal_id   = ""
  synchronization_job_id = ""
}

resource "azuread_synchronization_secret" "this" {
  service_principal_id = ""
}

resource "azuread_user_flow_attribute" "this" {
  data_type    = ""
  description  = ""
  display_name = ""
}

resource "azuread_user" "this" {
  display_name        = ""
  user_principal_name = ""
}