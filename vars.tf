## RESOURCES

variable "administrative_unit" {
  type = list(object({
    id                        = number
    display_name              = string
    description               = optional(string)
    hidden_membership_enabled = optional(bool)
    members                   = optional(set(string))
  }))
  default = []
}

variable "administrative_unit_member" {
  type = list(object({
    id                            = number
    administrative_unit_object_id = optional(any)
    member_object_id              = optional(any)
  }))
  default = []
}

variable "administrative_unit_role_member" {
  type = list(object({
    id                            = number
    administrative_unit_object_id = optional(any)
    member_object_id              = optional(any)
    role_object_id                = optional(any)
  }))
  default = []
}

variable "app_role_assignment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_api_access" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_app_role" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_certificate" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_fallback_public_client" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_federated_identity_credential" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_from_template" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_identifier_uri" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_known_clients" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_optional_claims" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_owner" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_password" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_permission_scope" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_pre_authorized" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_redirect_uris" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "application_registration" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "conditional_access_policy" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "named_location" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal_delegated_permission_grant" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "custom_directory_role" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "directory_role" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "directory_role_assignment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "directory_role_eligibility_schedule_request" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "directory_role_member" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "group" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "group_member" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package_assignment_policy" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package_catalog" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package_catalog_role_assignment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package_resource_catalog_association" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "access_package_resource_package_association" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "privileged_access_group_assignment_schedule" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "invitation" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal_certificate" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal_claims_mapping_policy_assignment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal_password" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_principal_token_signing_certificate" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "synchronization_job" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "synchronization_job_provision_on_demand" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "synchronization_secret" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "user_flow_attribute" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "user" {
  type = list(object({
    id = number
  }))
  default = []
}
