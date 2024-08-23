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
  count                          = length(var.application)
  display_name                   = lookup(var.application[count.index], "display_name")
  description                    = lookup(var.application[count.index], "description")
  device_only_auth_enabled       = lookup(var.application[count.index], "device_only_auth_enabled")
  fallback_public_client_enabled = lookup(var.application[count.index], "fallback_public_client_enabled")
  group_membership_claims        = lookup(var.application[count.index], "group_membership_claims")
  identifier_uris                = lookup(var.application[count.index], "identifier_uris")
  logo_image                     = lookup(var.application[count.index], "logo_image")
  marketing_url                  = lookup(var.application[count.index], "marketing_url")
  notes                          = lookup(var.application[count.index], "notes")
  oauth2_post_response_required  = lookup(var.application[count.index], "oauth2_post_response_required")
  owners                         = [data.azuread_client_config.this.object_id]
  prevent_duplicate_names        = lookup(var.application[count.index], "prevent_duplicate_names")
  privacy_statement_url          = lookup(var.application[count.index], "privacy_statement_url")
  service_management_reference   = lookup(var.application[count.index], "service_management_reference")
  sign_in_audience               = lookup(var.application[count.index], "sign_in_audience")
  support_url                    = lookup(var.application[count.index], "support_url")
  tags                           = lookup(var.application[count.index], "tags")
  template_id                    = try(data.azuread_application_template.this.template_id)
  terms_of_service_url           = lookup(var.application[count.index], "terms_of_service_url")

  dynamic "password" {
    for_each = try(lookup(var.application[count.index], "password") == null ? [] : ["password"])
    content {
      display_name = lookup(password.value, "display_name")
      start_date   = lookup(password.value, "start_date")
      end_date     = lookup(password.value, "end_date")
    }
  }
  dynamic "api" {
    for_each = try(lookup(var.application[count.index], "api") == null ? [] : ["api"])
    content {
      known_client_applications      = lookup(api.value, "known_client_applications")
      mapped_claims_enabled          = lookup(api.value, "mapped_claims_enabled")
      requested_access_token_version = lookup(api.value, "requested_access_token_version")

      dynamic "oauth2_permission_scope" {
        for_each = try(lookup(api.value, "oauth2_permission_scope") == null ? [] : ["oauth2_permission_scope"])
        iterator = oauth2
        content {
          id                         = lookup(oauth2.value, "id")
          admin_consent_description  = lookup(oauth2.value, "admin_consent_description")
          admin_consent_display_name = lookup(oauth2.value, "admin_consent_display_name")
          enabled                    = lookup(oauth2.value, "enabled")
          type                       = lookup(oauth2.value, "type")
          user_consent_description   = lookup(oauth2.value, "user_consent_description")
          user_consent_display_name  = lookup(oauth2.value, "user_consent_display_name")
          value                      = lookup(oauth2.value, "value")
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = try(lookup(var.application[count.index], "app_role") == null ? [] : ["app_role"])
    content {
      allowed_member_types = lookup(app_role.value, "allowed_member_types")
      description          = lookup(app_role.value, "description")
      display_name         = lookup(app_role.value, "display_name")
      id                   = lookup(app_role.value, "id")
      enabled              = lookup(app_role.value, "enabled")
      value                = lookup(app_role.value, "value")
    }
  }

  dynamic "feature_tags" {
    for_each = try(lookup(var.application[count.index], "feature_tags") == null ? [] : ["feature_tags"])
    iterator = tags
    content {
      custom_single_sign_on = lookup(tags.value, "custom_single_sign_on")
      enterprise            = lookup(tags.value, "enterprise")
      gallery               = lookup(tags.value, "gallery")
      hide                  = lookup(tags.value, "hide")
    }
  }

  dynamic "optional_claims" {
    for_each = try(lookup(var.application[count.index], "optional_claims") == null ? [] : ["optional_claims"])
    iterator = claims
    content {
      dynamic "access_token" {
        for_each = try(lookup(claims.value, "access_token") == null ? [] : ["access_token"])
        iterator = token
        content {
          name                  = lookup(token.value, "name")
          additional_properties = lookup(token.value, "additional_properties")
          essential             = lookup(token.value, "essential")
          source                = lookup(token.value, "source")
        }
      }
      dynamic "id_token" {
        for_each = try(lookup(claims.value, "id_token") == null ? [] : ["id_token"])
        iterator = token
        content {
          name                  = lookup(token.value, "name")
          additional_properties = lookup(token.value, "additional_properties")
          essential             = lookup(token.value, "essential")
          source                = lookup(token.value, "source")
        }
      }
      dynamic "saml2_token" {
        for_each = try(lookup(claims.value, "saml2_token") == null ? [] : ["saml2_token"])
        iterator = token
        content {
          name                  = lookup(token.value, "name")
          additional_properties = lookup(token.value, "additional_properties")
          essential             = lookup(token.value, "essential")
          source                = lookup(token.value, "source")
        }
      }
    }
  }

  dynamic "public_client" {
    for_each = try(lookup(var.application[count.index], "public_client") == null ? [] : ["public_client"])
    iterator = client
    content {
      redirect_uris = lookup(client.value, "redirect_uris")
    }
  }

  dynamic "required_resource_access" {
    for_each = try(lookup(var.application[count.index], "required_resource_access") == null ? [] : ["required_resource_access"])
    iterator = access
    content {
      resource_app_id = lookup(access.value, "resource_app_id")

      dynamic "resource_access" {
        for_each = try(lookup(access.value, "resource_access") == null ? [] : ["resource_access"])
        iterator = resource
        content {
          id   = lookup(resource.value, "id")
          type = lookup(resource.value, "type")
        }
      }
    }
  }

  dynamic "single_page_application" {
    for_each = try(lookup(var.application[count.index], "single_page_application") == null ? [] : ["single_page_application"])
    iterator = single
    content {
      redirect_uris = lookup(single.value, "redirect_uris")
    }
  }

  dynamic "web" {
    for_each = try(lookup(var.application[count.index], "web") == null ? [] : ["web"])
    content {
      homepage_url  = lookup(web.value, "homepage_url")
      logout_url    = lookup(web.value, "logout_url")
      redirect_uris = lookup(web.value, "redirect_uris")

      dynamic "implicit_grant" {
        for_each = try(lookup(web.value, "implicit_grant") == null ? [] : ["implicit_grant"])
        iterator = grant
        content {
          access_token_issuance_enabled = lookup(grant.value, "access_token_issuance_enabled")
          id_token_issuance_enabled     = lookup(grant.value, "id_token_issuance_enabled")
        }
      }
    }
  }
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

resource "azuread_service_principal" "this" {
  count                         = length(var.service_principal)
  account_enabled               = lookup(var.service_principal[count.index], "account_enabled")
  alternative_names             = lookup(var.service_principal[count.index], "alternative_names")
  app_role_assignment_required  = lookup(var.service_principal[count.index], "app_role_assignment_required")
  client_id                     = try(element(azuread_application.this.*.client_id, lookup(var.service_principal[count.index], "client_id")))
  description                   = lookup(var.service_principal[count.index], "description")
  login_url                     = lookup(var.service_principal[count.index], "login_url")
  notes                         = lookup(var.service_principal[count.index], "notes")
  notification_email_addresses  = lookup(var.service_principal[count.index], "notification_email_addresses")
  owners                        = [try(data.azuread_client_config.this.client_id)]
  preferred_single_sign_on_mode = lookup(var.service_principal[count.index], "preferred_single_sign_on_mode")
  tags                          = lookup(var.service_principal[count.index], "tags")
  use_existing                  = lookup(var.service_principal[count.index], "use_existing")

  dynamic "feature_tags" {
    for_each = try(lookup(var.service_principal[count.index], "feature_tags") == null ? [] : ["feature_tags"])
    iterator = feat
    content {
      custom_single_sign_on = lookup(feat.value, "custom_single_sign_on")
      enterprise            = lookup(feat.value, "enterprise")
      gallery               = lookup(feat.value, "gallery")
      hide                  = lookup(feat.value, "hide")
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = try(lookup(var.service_principal[count.index], "saml_single_sign_on") == null ? [] : ["saml_single_sign_on"])
    iterator = saml
    content {
      relay_state = lookup(saml.value, "realy_state")
    }
  }
}

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