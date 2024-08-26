## DATAS

variable "application_template_display_name" {
  type    = string
  default = null
}

## MODULES

variable "resource_group_name" {
  type = string
}

variable "certificate" {
  type = any
}

variable "keyvault" {
  type = any
}

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
    id                  = number
    app_role_id         = any
    principal_object_id = any
    resource_object_id  = any
  }))
  default = []
}

variable "application" {
  type = list(object({
    id                             = number
    display_name                   = string
    description                    = optional(string)
    device_only_auth_enabled       = optional(bool)
    fallback_public_client_enabled = optional(bool)
    group_membership_claims        = optional(list(string))
    identifier_uris                = optional(list(string))
    logo_image                     = optional(string)
    marketing_url                  = optional(string)
    notes                          = optional(string)
    oauth2_post_response_required  = optional(bool)
    owners                         = optional(list(string))
    prevent_duplicate_names        = optional(bool)
    privacy_statement_url          = optional(string)
    service_management_reference   = optional(string)
    sign_in_audience               = optional(string)
    support_url                    = optional(string)
    tags                           = optional(list(string))
    template_id                    = optional(any)
    terms_of_service_url           = optional(string)
    password = optional(list(object({
      display_name = string
      start_date   = optional(string)
      end_date     = optional(string)
    })))
    api = optional(list(object({
      known_client_applications      = optional(list(string))
      mapped_claims_enabled          = optional(bool)
      requested_access_token_version = optional(number)
      oauth2_permission_scope = optional(list(object({
        id                         = optional(string)
        admin_consent_description  = optional(string)
        admin_consent_display_name = optional(string)
        enabled                    = optional(bool)
        type                       = optional(string)
        user_consent_description   = optional(string)
        user_consent_display_name  = optional(string)
        value                      = optional(string)
      })))
    })))
    app_role = optional(list(object({
      allowed_member_types = list(string)
      description          = string
      display_name         = string
      id                   = string
      enabled              = optional(bool)
      value                = optional(string)
    })))
    feature_tags = optional(list(object({
      custom_single_sign_on = optional(bool)
      enterprise            = optional(bool)
      gallery               = optional(bool)
      hide                  = optional(bool)
    })))
    optional_claims = optional(list(object({
      access_token = optional(list(object({
        name                  = string
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })))
      id_token = optional(list(object({
        name                  = string
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })))
      saml2_token = optional(list(object({
        name                  = string
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })))
    })))
    public_client = optional(list(object({
      redirect_uris = optional(list(string))
    })))
    required_resource_access = optional(list(object({
      resource_app_id = string
      resource_access = optional(list(object({
        id   = string
        type = string
      })))
    })))
    single_page_application = optional(list(object({
      redirect_uris = optional(list(string))
    })))
    web = optional(list(object({
      homepage_url  = optional(string)
      logout_url    = optional(string)
      redirect_uris = optional(list(string))
      implicit_grant = optional(list(object({
        access_token_issuance_enabled = optional(bool)
        id_token_issuance_enabled     = optional(bool)
      })))
    })))
  }))
  default = []
}

variable "application_api_access" {
  type = list(object({
    id             = number
    api_client_id  = any
    application_id = any
    role_ids       = optional(list(any))
    scope_ids      = optional(list(any))
  }))
  default = []
}

variable "application_app_role" {
  type = list(object({
    id                   = number
    allowed_member_types = list(any)
    application_id       = any
    description          = string
    display_name         = string
    role_id              = any
    value                = optional(string)
  }))
  default = []
}

variable "application_certificate" {
  type = list(object({
    id             = number
    certificate_id = any
    application_id = any
    type           = string
    encoding       = string
  }))
  default = []

  validation {
    condition     = length([for a in var.application_certificate : true if contains(["pem", "base64", "hex"], a.encoding)]) == length(var.application_certificate)
    error_message = "Must be one of pem, base64 or hex."
  }

  validation {
    condition     = length([for b in var.application_certificate : true if contains(["AsymmetricX509Cert", "Symmetric"], b.type)]) == length(var.application_certificate)
    error_message = "Must be one of AsymmetricX509Cert or Symmetric."
  }
}

variable "application_fallback_public_client" {
  type = list(object({
    id             = number
    application_id = any
    enabled        = bool
  }))
  default = []
}

variable "application_federated_identity_credential" {
  type = list(object({
    id             = number
    application_id = any
    display_name   = string
    description    = string
    audiences      = string
    issuer         = string
    subject        = string
  }))
  default = []
}

variable "application_from_template" {
  type = list(object({
    id           = number
    display_name = string
    template_id  = optional(any)
  }))
  default = []
}

variable "application_identifier_uri" {
  type = list(object({
    id             = number
    application_id = any
    identifier_uri = string
  }))
  default = []
}

variable "application_known_clients" {
  type = list(object({
    id               = number
    application_id   = any
    known_client_ids = list(any)
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
    id                            = number
    account_enabled               = optional(bool)
    alternative_names             = optional(list(string))
    app_role_assignment_required  = optional(bool)
    client_id                     = optional(any)
    description                   = optional(string)
    login_url                     = optional(string)
    notes                         = optional(string)
    notification_email_addresses  = optional(list(string))
    owners                        = optional(list(string))
    preferred_single_sign_on_mode = optional(string)
    tags                          = optional(list(string))
    use_existing                  = optional(bool)
    feature_tags = optional(list(object({
      custom_single_sign_on = optional(bool)
      enterprise            = optional(bool)
      gallery               = optional(bool)
      hide                  = optional(bool)
    })))
    saml_single_sign_on = optional(list(object({
      relay_state = optional(string)
    })))
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
