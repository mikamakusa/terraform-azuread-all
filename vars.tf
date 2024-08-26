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
    certificate_id = optional(any)
    value          = optional(string)
    application_id = any
    type           = string
    encoding       = string
    end_date       = optional(string)
    start_date     = optional(string)
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
    id             = number
    application_id = any
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
  }))
  default = []

  validation {
    condition = length([
      for a in var.application_optional_claims : true if contains(["cloud_displayname", "dns_domain_and_sam_account_name", "emit_as_roles", "include_externally_authenticated_upn_without_hash", "include_externally_authenticated_upn", "max_size_limit", "netbios_domain_and_sam_account_name", "on_premise_security_identifier", "sam_account_name", "use_guid"], a.access_token.additional_properties)
    ]) == length(var.application_optional_claims)
    error_message = "Possible values are: cloud_displayname, dns_domain_and_sam_account_name, emit_as_roles, include_externally_authenticated_upn_without_hash, include_externally_authenticated_upn, max_size_limit, netbios_domain_and_sam_account_name, on_premise_security_identifier, sam_account_name, and use_guid."
  }

  validation {
    condition = length([
      for b in var.application_optional_claims : true if contains(["cloud_displayname", "dns_domain_and_sam_account_name", "emit_as_roles", "include_externally_authenticated_upn_without_hash", "include_externally_authenticated_upn", "max_size_limit", "netbios_domain_and_sam_account_name", "on_premise_security_identifier", "sam_account_name", "use_guid"], b.id_token.additional_properties)
    ]) == length(var.application_optional_claims)
    error_message = "Possible values are: cloud_displayname, dns_domain_and_sam_account_name, emit_as_roles, include_externally_authenticated_upn_without_hash, include_externally_authenticated_upn, max_size_limit, netbios_domain_and_sam_account_name, on_premise_security_identifier, sam_account_name, and use_guid."
  }

  validation {
    condition = length([
      for c in var.application_optional_claims : true if contains(["cloud_displayname", "dns_domain_and_sam_account_name", "emit_as_roles", "include_externally_authenticated_upn_without_hash", "include_externally_authenticated_upn", "max_size_limit", "netbios_domain_and_sam_account_name", "on_premise_security_identifier", "sam_account_name", "use_guid"], c.saml2_token.additional_properties)
    ]) == length(var.application_optional_claims)
    error_message = "Possible values are: cloud_displayname, dns_domain_and_sam_account_name, emit_as_roles, include_externally_authenticated_upn_without_hash, include_externally_authenticated_upn, max_size_limit, netbios_domain_and_sam_account_name, on_premise_security_identifier, sam_account_name, and use_guid."
  }
}

variable "application_owner" {
  type = list(object({
    id              = number
    application_id  = any
    owner_object_id = any
  }))
  default = []
}

variable "application_password" {
  type = list(object({
    id                  = number
    application_id      = optional(any)
    display_name        = optional(string)
    end_date            = optional(string)
    end_date_relative   = optional(string)
    rotate_when_changed = optional(map(any))
    start_date          = optional(string)
  }))
  default = []
}

variable "application_permission_scope" {
  type = list(object({
    id                         = number
    admin_consent_description  = string
    admin_consent_display_name = string
    application_id             = any
    scope_id                   = string
    value                      = string
    type                       = string
    user_consent_description   = string
    user_consent_display_name  = string
  }))
  default = []
}

variable "application_pre_authorized" {
  type = list(object({
    id                   = number
    permission_ids       = list(any)
    application_id       = any
    authorized_client_id = any
  }))
  default = []
}

variable "application_redirect_uris" {
  type = list(object({
    id             = number
    application_id = any
    redirect_uris  = list(string)
    type           = string
  }))
  default = []
}

variable "application_registration" {
  type = list(object({
    id                                     = number
    display_name                           = string
    description                            = optional(string)
    group_membership_claims                = optional(list(string))
    homepage_url                           = optional(string)
    implicit_access_token_issuance_enabled = optional(bool)
    implicit_id_token_issuance_enabled     = optional(bool)
    logout_url                             = optional(string)
    marketing_url                          = optional(string)
    notes                                  = optional(string)
    privacy_statement_url                  = optional(string)
    requested_access_token_version         = optional(number)
    service_management_reference           = optional(string)
    sign_in_audience                       = optional(string)
    support_url                            = optional(string)
    terms_of_service_url                   = optional(string)
  }))
  default = []
}

variable "conditional_access_policy" {
  type = list(object({
    id           = number
    display_name = string
    state        = string
    conditions = optional(list(object({
      client_app_types              = list(string)
      service_principal_risk_levels = list(string)
      sign_in_risk_levels           = list(string)
      user_risk_levels              = list(string)
      applications = optional(list(object({
        excluded_applications = optional(list(string))
        included_applications = optional(list(string))
        included_user_actions = optional(list(string))
      })))
      client_applications = optional(list(object({
        excluded_service_principals = optional(list(string))
        included_service_principals = optional(list(string))
      })))
      devices = optional(list(object({
        filter = optional(list(object({
          mode = string
          rule = string
        })))
      })))
      locations = optional(list(object({
        included_locations = list(string)
        excluded_locations = optional(list(string))
      })))
      platforms = optional(list(object({
        included_platforms = list(string)
        excluded_platforms = optional(list(string))
      })))
      users = optional(list(object({
        excluded_groups = optional(list(string))
        excluded_roles  = optional(list(string))
        excluded_users  = optional(list(string))
        included_groups = optional(list(string))
        included_roles  = optional(list(string))
        included_users  = optional(list(string))
        excluded_guests_or_external_users = optional(list(object({
          guestçor_external_user_type = list(string)
          external_tenants = optional(list(object({
            membership_kind = string
            members         = optional(list(string))
          })))
        })))
        included_guests_or_external_users = optional(list(object({
          guestçor_external_user_type = list(string)
          external_tenants = optional(list(object({
            membership_kind = string
            members         = optional(list(string))
          })))
        })))
      })))
    })))
    grant_controls = optional(list(object({
      operator                          = string
      authentication_strength_policy_id = optional(string)
      built_in_controls                 = optional(list(string))
      custom_authentication_factors     = optional(list(string))
      terms_of_use                      = optional(list(string))
    })))
    session_controls = optional(list(object({
      application_enforced_restrictions_enabled = optional(bool)
      cloud_app_security_policy                 = optional(string)
      disable_resilience_defaults               = optional(bool)
      persistent_browser_mode                   = optional(string)
      sign_in_frequency                         = optional(number)
      sign_in_frequency_authentication_type     = optional(string)
      sign_in_frequency_interval                = optional(string)
      sign_in_frequency_period                  = optional(string)
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.conditional_access_policy : true if contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], a.state)
    ]) == length(var.conditional_access_policy)
    error_message = "Possible values are : enabled, disabled and enabledForReportingButNotEnforced."
  }

  validation {
    condition = length([
      for b in var.conditional_access_policy : true if contains(["all", "browser", "mobileAppsAndDesktopClients", "exchangeActiveSync", "easSupported", "other"], b.conditions.client_app_types)
    ])
    error_message = "Possible values are: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, easSupported and other."
  }

  validation {
    condition = length([
      for c in var.conditional_access_policy : true if contains(["low", "medium", "high", "none", "unknownFutureValue"], c.conditions.service_principal_risk_levels)
    ])
    error_message = "Possible values are: low, medium, high, none, unknownFutureValue."
  }

  validation {
    condition = length([
      for d in var.conditional_access_policy : true if contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], d.conditions.sign_in_risk_levels)
    ])
    error_message = "Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  }

  validation {
    condition = length([
      for e in var.conditional_access_policy : true if contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], e.conditions.user_risk_levels)
    ])
    error_message = "Possible values are: low, medium, high, hidden, none, unknownFutureValue."
  }

  validation {
    condition = length([
      for f in var.conditional_access_policy : true if contains(["included_applications", "included_user_actions"], f.conditions.applications.included_applications)
    ])
    error_message = "One of included_applications or included_user_actions must be specified."
  }

  validation {
    condition = length([
      for g in var.conditional_access_policy : true if contains(["urn:user:registerdevice", "urn:user:registersecurityinfo"], g.conditions.applications.included_user_actions)
    ])
    error_message = "Supported values are urn:user:registerdevice and urn:user:registersecurityinfo."
  }

  validation {
    condition = length([
      for h in var.conditional_access_policy : true if contains(["include", "exclude"], h.conditions.devices.filter.mode)
    ])
    error_message = "Supported values are include and exclude."
  }

  validation {
    condition = length([
      for i in var.conditional_access_policy : true if contains(["all", "android", "iOS", "linux", "macOS", "windows", "windowsPhone", "unknownFutureValue"], i.conditions.platforms.excluded_platforms)
    ])
    error_message = "Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }

  validation {
    condition = length([
      for j in var.conditional_access_policy : true if contains(["all", "android", "iOS", "linux", "macOS", "windows", "windowsPhone", "unknownFutureValue"], j.conditions.platforms.included_platforms)
    ])
    error_message = "Possible values are: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }

  validation {
    condition = length([
      for k in var.conditional_access_policy : true if contains(["block", "mfa", "approvedApplication", "compliantApplication", "compliantDevice", "domainJoinedDevice", "passwordChange", "unknownFutureValue"], k.grant_controls.built_in_controls)
    ])
    error_message = "Possible values are: block, mfa, approvedApplication, compliantApplication, compliantDevice, domainJoinedDevice, passwordChange or unknownFutureValue."
  }

  validation {
    condition = length([
      for l in var.conditional_access_policy : true if contains(["blockDownloads", "mcasConfigured", "monitorOnly", "unknownFutureValue"], l.session_controls.cloud_app_security_policy)
    ])
    error_message = "Possible values are: blockDownloads, mcasConfigured, monitorOnly or unknownFutureValue."
  }

  validation {
    condition = length([
      for l in var.conditional_access_policy : true if contains(["always", "never"], l.session_controls.persistent_browser_mode)
    ])
    error_message = "Possible values are: always, never."
  }

  validation {
    condition = length([
      for l in var.conditional_access_policy : true if contains(["primaryAndSecondaryAuthentication", "secondaryAuthentication"], l.session_controls.sign_in_frequency_authentication_type)
    ])
    error_message = "Possible values are: primaryAndSecondaryAuthentication or secondaryAuthentication."
  }

  validation {
    condition = length([
      for m in var.conditional_access_policy : true if contains(["timeBased", "everyTime"], m.session_controls.sign_in_frequency_interval)
    ])
    error_message = "Possible values are: timeBased or everyTime."
  }

  validation {
    condition = length([
      for m in var.conditional_access_policy : true if contains(["hours", "days"], m.session_controls.sign_in_frequency_period)
    ])
    error_message = "Possible values are: timeBased or everyTime."
  }
}

variable "named_location" {
  type = list(object({
    id           = number
    display_name = string
    country = optional(list(object({
      countries_and_regions                 = list(string)
      include_unknown_countries_and_regions = optional(bool)
    })))
    ip = optional(list(object({
      ip_ranges = list(string)
      trusted   = optional(bool)
    })))
  }))
  default = []
}

variable "service_principal_delegated_permission_grant" {
  type = list(object({
    id                   = number
    claim_values         = list(string)
    service_principal_id = any
    user_id              = optional(any)
  }))
  default = []
}

variable "custom_directory_role" {
  type = list(object({
    id           = number
    display_name = string
    enabled      = bool
    version      = string
    description  = optional(string)
    template_id  = optional(string)
    permissions = list(object({
      allowed_resource_actions = list(string)
    }))
  }))
  default = []
}

variable "directory_role" {
  type = list(object({
    id           = number
    display_name = optional(string)
    template_id  = optional(string)
  }))
  default = []
}

variable "directory_role_assignment" {
  type = list(object({
    id                  = number
    principal_object_id = any
    role_id             = any
    app_scope_id        = optional(any)
    application_id      = optional(any)
  }))
  default = []
}

variable "directory_role_eligibility_schedule_request" {
  type = list(object({
    id                 = number
    directory_scope_id = string
    justification      = string
    principal_id       = any
    role_definition_id = any
  }))
  default = []
}

variable "directory_role_member" {
  type = list(object({
    id               = number
    member_object_id = optional(any)
    role_object_id   = optional(any)
  }))
  default = []
}

variable "group" {
  type = list(object({
    id                         = number
    display_name               = string
    administrative_unit_ids    = optional(list(string))
    assignable_to_role         = optional(bool)
    auto_subscribe_new_members = optional(bool)
    behaviors                  = optional(list(string))
    description                = optional(string)
    external_senders_allowed   = optional(bool)
    hide_from_address_lists    = optional(bool)
    hide_from_outlook_clients  = optional(bool)
    mail_enabled               = optional(bool)
    mail_nickname              = optional(string)
    members                    = optional(list(any))
    onpremises_group_type      = optional(string)
    user_id                    = optional(list(any))
    prevent_duplicate_names    = optional(bool)
    provisioning_options       = optional(list(string))
    security_enabled           = optional(bool)
    theme                      = optional(string)
    types                      = optional(list(string))
    visibility                 = optional(string)
    writeback_enabled          = optional(bool)
    dynamic_membership = optional(list(object({
      enabled = bool
      role    = string
    })))
  }))
  default = []
}

variable "group_member" {
  type = list(object({
    id               = number
    group_object_id  = any
    member_object_id = any
  }))
  default = []
}

variable "access_package" {
  type = list(object({
    id           = number
    catalog_id   = any
    description  = string
    display_name = string
    hidden       = optional(bool)
  }))
  default = []
}

variable "access_package_assignment_policy" {
  type = list(object({
    id                = number
    access_package_id = any
    description       = string
    display_name      = string
    duration_in_days  = optional(number)
    expiration_date   = optional(string)
    extension_enabled = optional(bool)
    approval_settings = optional(list(object({
      approval_required                = optional(bool)
      approval_required_for_extension  = optional(bool)
      requestor_justification_required = optional(bool)
      approval_stage = optional(list(object({
        approval_timeout_in_days            = number
        alternative_approval_enabled        = optional(bool)
        approver_justification_required     = optional(bool)
        enable_alternative_approval_in_days = optional(number)
        alternative_approver = optional(list(object({
          subject_type = string
          backup       = optional(bool)
          object_id    = optional(any)
        })))
        primary_approver = optional(list(object({
          subject_type = string
          backup       = optional(bool)
          object_id    = optional(any)
        })))
      })))
    })))
    assignment_review_settings = optional(list(object({
      access_recommendation_enabled   = optional(bool)
      access_review_timeout_behavior  = optional(string)
      approver_justification_required = optional(bool)
      duration_in_days                = optional(number)
      enabled                         = optional(bool)
      review_frequency                = optional(string)
      review_type                     = optional(string)
      starting_on                     = optional(string)
      reviewer = optional(list(object({
        subject_type = string
        backup       = optional(bool)
        object_id    = optional(any)
      })))
    })))
    question = optional(list(object({
      required = optional(bool)
      sequence = optional(number)
      choice = optional(list(object({
        actual_value = string
        display_value = list(object({
          content       = string
          language_code = string
        }))
      })))
      text = list(object({
        default_text = string
        localized_text = list(object({
          content       = string
          language_code = string
        }))
      }))
    })))
    requestor_settings = optional(list(object({
      requests_accepted = optional(bool)
      scope_type        = optional(string)
      requestor = optional(list(object({
        subject_type = string
        object_id    = optional(any)
      })))
    })))
  }))
  default = []
}

variable "access_package_catalog" {
  type = list(object({
    id                 = number
    description        = string
    display_name       = string
    externally_visible = optional(bool)
    published          = optional(bool)
  }))
  default = []
}

variable "access_package_catalog_role_assignment" {
  type = list(object({
    id                  = number
    catalog_id          = any
    principal_object_id = any
    role_id             = optional(any)
  }))
  default = []
}

variable "access_package_resource_catalog_association" {
  type = list(object({
    id                     = number
    catalog_id             = any
    resource_origin_id     = any
    resource_origin_system = string
  }))
  default = []
}

variable "access_package_resource_package_association" {
  type = list(object({
    id                              = number
    access_package_id               = any
    catalog_resource_association_id = any
    access_type                     = optional(string)
  }))
  default = []

  validation {
    condition     = length([for a in var.access_package_resource_package_association : true if contains(["Member", "Owner"], a.access_type)]) == length(var.access_package_resource_package_association)
    error_message = "Valid values are Member, or Owner. The default is Member."
  }
}

variable "privileged_access_group_assignment_schedule" {
  type = list(object({
    id                   = number
    assignment_type      = string
    group_id             = any
    user_id              = any
    justification        = optional(string)
    ticket_number        = optional(string)
    ticket_system        = optional(string)
    start_date           = optional(string)
    expiration_date      = optional(string)
    duration             = optional(string)
    permanent_assignment = optional(bool)
  }))
  default = []
  validation {
    condition     = length([for a in var.privileged_access_group_assignment_schedule : true if contains(["Member", "Owner"], a.assignment_type)]) == length(var.privileged_access_group_assignment_schedule)
    error_message = "Valid values are Member, or Owner. The default is Member."
  }
}

variable "privileged_access_group_eligibility_schedule" {
  type = list(object({
    id                   = number
    assignment_type      = string
    group_id             = any
    user_id              = any
    justification        = optional(string)
    ticket_number        = optional(string)
    ticket_system        = optional(string)
    start_date           = optional(string)
    expiration_date      = optional(string)
    duration             = optional(string)
    permanent_assignment = optional(bool)
  }))
  default = []

  validation {
    condition     = length([for a in var.privileged_access_group_eligibility_schedule : true if contains(["Member", "Owner"], a.assignment_type)]) == length(var.privileged_access_group_eligibility_schedule)
    error_message = "Valid values are Member, or Owner. The default is Member."
  }
}

variable "invitation" {
  type = list(object({
    id                 = number
    redirect_url       = string
    user_email_address = string
    user_display_name  = optional(string)
    user_type          = optional(string, "Guest")
    message = optional(list(object({
      additional_recipients = optional(string)
      body                  = optional(string)
      language              = optional(string, "en-US")
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.invitation : true if contains(["Member", "Guest"], a.user_type)]) == length(var.invitation)
    error_message = "Valid values are Member, or Guest. The default is Guest."
  }
}

variable "authentication_strength_policy" {
  type = list(object({
    id                   = number
    allowed_combinations = list(string)
    display_name         = string
    description          = optional(string)
  }))
  default = []
}

variable "claims_mapping_policy" {
  type = list(object({
    id           = number
    definition   = list(string)
    display_name = string
  }))
  default = []
}

variable "group_role_management_policy" {
  type = list(object({
    id       = number
    group_id = any
    role_id  = string
    activation_rules = optional(list(object({
      maximum_duration                                   = optional(string)
      require_approval                                   = optional(bool)
      require_justification                              = optional(bool)
      require_multifactor_authentication                 = optional(bool)
      require_ticket_info                                = optional(bool)
      required_conditional_access_authentication_context = optional(string)
      approval_stage = optional(list(object({
        primary_approver = optional(list(object({
          object_id = any
          type      = optional(string)
        })))
      })))
    })))
    active_assignment_rules = optional(list(object({
      expiration_required                = optional(bool)
      expire_after                       = optional(string)
      require_justification              = optional(bool)
      require_multifactor_authentication = optional(bool)
      require_ticket_info                = optional(bool)
    })))
    eligible_assignment_rules = optional(list(object({
      expiration_required = optional(bool)
      expire_after        = optional(string)
    })))
    notification_rules = optional(list(object({
      active_assignments = optional(list(object({
        admin_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        approver_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        assignee_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
      })))
      eligible_activations = optional(list(object({
        admin_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        approver_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        assignee_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
      })))
      eligible_assignments = optional(list(object({
        admin_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        approver_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
        assignee_notifications = optional(list(object({
          default_recipients    = bool
          notification_level    = string
          additional_recipients = optional(list(string))
        })))
      })))
    })))
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
    id                   = number
    service_principal_id = any
    value                = string
    encoding             = optional(string)
    end_date             = optional(string)
    end_date_relative    = optional(string)
    key_id               = optional(string)
    start_date           = optional(string)
    type                 = string
    file_extension       = optional(string)
  }))
  default = []

  validation {
    condition     = length([for a in var.service_principal_certificate : true if contains(["AsymmetricX509Cert", "Symmetric"], a.type)]) == length(var.service_principal_certificate)
    error_message = "Must be one of AsymmetricX509Cert or Symmetric."
  }
}

variable "service_principal_claims_mapping_policy_assignment" {
  type = list(object({
    id                       = number
    claims_mapping_policy_id = any
    service_principal_id     = any
  }))
  default = []
}

variable "service_principal_password" {
  type = list(object({
    id                   = number
    service_principal_id = any
    end_date             = optional(string)
    end_date_relative    = optional(string)
    rotate_when_changed  = optional(map(string))
    start_date           = optional(string)
  }))
  default = []
}

variable "service_principal_token_signing_certificate" {
  type = list(object({
    id                   = number
    service_principal_id = any
    display_name         = optional(string)
    end_date             = optional(string)
  }))
  default = []
}

variable "synchronization_job" {
  type = list(object({
    id                   = number
    service_principal_id = any
    template_id          = string
    enabled              = optional(bool)
  }))
  default = []
}

variable "synchronization_job_provision_on_demand" {
  type = list(object({
    id                     = number
    service_principal_id   = any
    synchronization_job_id = any
    triggers               = optional(string)
    parameter = list(object({
      rule_id = any
      subject = list(object({
        group_id         = any
        object_type_name = string
      }))
    }))
  }))
  default = []
}

variable "synchronization_secret" {
  type = list(object({
    id                   = number
    service_principal_id = any
    credential = list(object({
      key   = string
      value = string
    }))
  }))
  default = []
}

variable "user_flow_attribute" {
  type = list(object({
    id           = number
    data_type    = string
    description  = string
    display_name = string
  }))
  default = []

  validation {
    condition     = length([for a in var.user_flow_attribute : true if contains(["boolean", "dateTime", "int64", "string", "stringCollection"], a.data_type)]) == length(var.user_flow_attribute)
    error_message = "Possible values are boolean, dateTime, int64, string or stringCollection."
  }
}

variable "user" {
  type = list(object({
    id                          = number
    display_name                = string
    user_principal_name         = string
    account_enabled             = optional(bool)
    age_group                   = optional(string)
    business_phones             = optional(list(string))
    city                        = optional(string)
    company_name                = optional(string)
    consent_provided_for_minor  = optional(string)
    cost_center                 = optional(string)
    country                     = optional(string)
    department                  = optional(string)
    disable_password_expiration = optional(bool)
    disable_strong_password     = optional(bool)
    division                    = optional(string)
    employee_id                 = optional(string)
    employee_type               = optional(string)
    fax_number                  = optional(string)
    force_password_change       = optional(bool)
    given_name                  = optional(string)
    job_title                   = optional(string)
    mail                        = optional(string)
    mail_nickname               = optional(string)
    mobile_phone                = optional(string)
    office_location             = optional(string)
    onpremises_immutable_id     = optional(string)
    other_mails                 = optional(list(string))
    password                    = optional(string)
    postal_code                 = optional(string)
    preferred_language          = optional(string)
    show_in_address_list        = optional(bool)
    state                       = optional(string)
    street_address              = optional(string)
    surname                     = optional(string)
    usage_location              = optional(string)
  }))
  default = []
}
