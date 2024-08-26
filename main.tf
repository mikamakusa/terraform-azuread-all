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
  count               = length(var.service_principal) == 0 ? 0 : length(var.app_role_assignment)
  app_role_id         = try(element(azuread_service_principal.this.*.app_role_ids, lookup(var.app_role_assignment[count.index], "app_role_id")))
  principal_object_id = try(element(azuread_service_principal.this.*.object_id, lookup(var.app_role_assignment[count.index], "principal_object_id")))
  resource_object_id  = try(element(azuread_service_principal.this.*.object_id, lookup(var.app_role_assignment[count.index], "resource_object_id")))
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
  count          = length(var.application_registration) == 0 ? 0 : length(var.application_api_access)
  api_client_id  = data.azuread_application_published_app_ids.this.result
  application_id = try(element(azuread_application_registration.this.*.id, lookup(var.application_api_access[count.index], "application_id")))
  role_ids       = try(element(azuread_service_principal.this.*.app_role_ids, lookup(var.application_api_access[count.index], "role_ids")))
  scope_ids      = try(element(azuread_service_principal.this.*.oauth2_permission_scope_ids, lookup(var.application_api_access[count.index], "scope_ids")))
}

resource "azuread_application_app_role" "this" {
  count                = length(var.application) == 0 ? 0 : length(var.application_app_role)
  allowed_member_types = lookup(var.application_app_role[count.index], "allowed_member_types")
  application_id       = try(element(azuread_application.this.*.id, lookup(var.application_app_role[count.index], "application_id")))
  description          = lookup(var.application_app_role[count.index], "description")
  display_name         = lookup(var.application_app_role[count.index], "display_name")
  role_id              = lookup(var.application_app_role[count.index], "role_id")
  value                = lookup(var.application_app_role[count.index], "value")
}

resource "azuread_application_certificate" "this" {
  count          = (length(var.application) && length(var.certificate)) == 0 ? 0 : length(var.application_certificate)
  value          = try(element(module.keyvault.*.certificate_attribute_data, lookup(var.application_certificate[count.index], "")))
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_certificate[count.index], "application_id")))
  type           = lookup(var.application_certificate[count.index], "type")
  encoding       = lookup(var.application_certificate[count.index], "encoding")
  end_date       = try(element(module.keyvault.*.certificate_attribute_expires, lookup(var.application_certificate[count.index], "certificate_id")))
  start_date     = try(element(module.keyvault.*.certificate_attribute_not_before, lookup(var.application_certificate[count.index], "certificate_id")))
}

resource "azuread_application_fallback_public_client" "this" {
  count          = length(var.application) == 0 ? 0 : length(var.application_fallback_public_client)
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_fallback_public_client[count.index], "application_id")))
  enabled        = lookup(var.application_fallback_public_client[count.index], "enabled")
}

resource "azuread_application_federated_identity_credential" "this" {
  count          = length(var.application) == 0 ? 0 : length(var.application_federated_identity_credential)
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_federated_identity_credential[count.index], "application_id")))
  display_name   = lookup(var.application_federated_identity_credential[count.index], "display_name")
  description    = lookup(var.application_federated_identity_credential[count.index], "description")
  audiences      = lookup(var.application_federated_identity_credential[count.index], "audiences")
  issuer         = lookup(var.application_federated_identity_credential[count.index], "issuer")
  subject        = lookup(var.application_federated_identity_credential[count.index], "subject")
}

resource "azuread_application_from_template" "this" {
  count        = length(var.application_from_template)
  display_name = lookup(var.application_from_template[count.index], "display_name")
  template_id  = data.azuread_application_template.this.template_id
}

resource "azuread_application_identifier_uri" "this" {
  count          = length(var.application) == 0 ? 0 : length(azuread_application_identifier_uri)
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_identifier_uri[count.index], "application_id")))
  identifier_uri = lookup(var.application_identifier_uri[count.index], "identifier_uri")
}

resource "azuread_application_known_clients" "this" {
  count            = (length(var.application) && length(var.application_registration)) == 0 ? 0 : length(var.application_known_clients)
  application_id   = try(element(azuread_application.this.*.id, lookup(var.application_known_clients[count.index], "application_id")))
  known_client_ids = [try(element(azuread_application_registration.this.*.id, lookup(var.application_known_clients[count.index], "known_client_ids")))]
}

resource "azuread_application_optional_claims" "this" {
  count          = length(var.application) == 0 ? 0 : length(var.application_optional_claims)
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_optional_claims[count.index], "application_id")))

  dynamic "access_token" {
    for_each = try(lookup(var.application_optional_claims[count.index], "access_token") == null ? [] : ["access_token"])
    content {
      name                  = lookup(access_token.value, "name")
      additional_properties = lookup(access_token.value, "additional_properties")
      essential             = lookup(access_token.value, "essential")
      source                = lookup(access_token.value, "source")
    }
  }

  dynamic "id_token" {
    for_each = try(lookup(var.application_optional_claims[count.index], "id_token") == null ? [] : ["id_token"])
    content {
      name                  = lookup(id_token.value, "name")
      additional_properties = lookup(id_token.value, "additional_properties")
      essential             = lookup(id_token.value, "essential")
      source                = lookup(id_token.value, "source")
    }
  }

  dynamic "saml2_token" {
    for_each = try(lookup(var.application_optional_claims[count.index], "saml2_token") == null ? [] : ["saml2_token"])
    content {
      name                  = lookup(saml2_token.value, "name")
      additional_properties = lookup(saml2_token.value, "additional_properties")
      essential             = lookup(saml2_token.value, "essential")
      source                = lookup(saml2_token.value, "source")
    }
  }
}

resource "azuread_application_owner" "this" {
  count           = (length(var.application) && length(var.user)) == 0 ? 0 : length(var.application_owner)
  application_id  = try(element(azuread_application.this.*.id, lookup(var.application_owner[count.index], "application_id")))
  owner_object_id = try(element(azuread_user.this.*.object_id, lookup(var.application_owner[count.index], "owner_object_id")))
}

resource "azuread_application_password" "this" {
  count               = length(var.application_password)
  application_id      = try(element(azuread_application.this.*.id, lookup(var.application_password[count.index], "application_id")))
  display_name        = lookup(var.application_password[count.index], "display_name")
  end_date            = lookup(var.application_password[count.index], "end_date")
  end_date_relative   = lookup(var.application_password[count.index], "end_date_relative")
  rotate_when_changed = lookup(var.application_password[count.index], "rotate_when_changed")
  start_date          = lookup(var.application_password[count.index], "start_date")
}

resource "azuread_application_permission_scope" "this" {
  count                      = length(var.application) == 0 ? 0 : length(var.application_permission_scope)
  admin_consent_description  = lookup(var.application_permission_scope[count.index], "admin_consent_description")
  admin_consent_display_name = lookup(var.application_permission_scope[count.index], "admin_consent_display_name")
  application_id             = try(element(azuread_application.this.*.id, lookup(var.application_permission_scope[count.index], "application_id")))
  scope_id                   = lookup(var.application_permission_scope[count.index], "scope_id")
  value                      = lookup(var.application_permission_scope[count.index], "value")
  type                       = lookup(var.application_permission_scope[count.index], "type")
  user_consent_description   = lookup(var.application_permission_scope[count.index], "user_consent_description")
  user_consent_display_name  = lookup(var.application_permission_scope[count.index], "user_consent_display_name")
}

resource "azuread_application_pre_authorized" "this" {
  count                = (length(var.application) && length(var.application_registration)) == 0 ? 0 : length(var.application_pre_authorized)
  permission_ids       = lookup(var.application_pre_authorized[count.index], "permission_ids")
  application_id       = try(element(azuread_application.this.*.id, lookup(var.application_pre_authorized[count.index], "application_id")))
  authorized_client_id = try(element(azuread_application_registration.this.*.client_id, lookup(var.application_pre_authorized[count.index], "authorized_client_id")))
}

resource "azuread_application_redirect_uris" "this" {
  count          = length(var.application) == 0 ? 0 : length(var.application_redirect_uris)
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_redirect_uris[count.index], "application_id")))
  redirect_uris  = lookup(var.application_redirect_uris[count.index], "redirect_uris")
  type           = lookup(var.application_redirect_uris[count.index], "type")
}

resource "azuread_application_registration" "this" {
  count                                  = length(var.application_registration)
  display_name                           = lookup(var.application_registration[count.index], "display_name")
  description                            = lookup(var.application_registration[count.index], "description")
  group_membership_claims                = lookup(var.application_registration[count.index], "group_membership_claims")
  homepage_url                           = lookup(var.application_registration[count.index], "homepage_url")
  implicit_access_token_issuance_enabled = lookup(var.application_registration[count.index], "implicit_access_token_issuance_enabled")
  implicit_id_token_issuance_enabled     = lookup(var.application_registration[count.index], "implicit_id_token_issuance_enabled")
  logout_url                             = lookup(var.application_registration[count.index], "logout_url")
  marketing_url                          = lookup(var.application_registration[count.index], "marketing_url")
  notes                                  = lookup(var.application_registration[count.index], "notes")
  privacy_statement_url                  = lookup(var.application_registration[count.index], "privacy_statement_url")
  requested_access_token_version         = lookup(var.application_registration[count.index], "requested_access_token_version")
  service_management_reference           = lookup(var.application_registration[count.index], "service_management_reference")
  sign_in_audience                       = lookup(var.application_registration[count.index], "sign_in_audience")
  support_url                            = lookup(var.application_registration[count.index], "support_url")
  terms_of_service_url                   = lookup(var.application_registration[count.index], "terms_of_service_url")
}

resource "azuread_conditional_access_policy" "this" {
  count        = length(var.conditional_access_policy)
  display_name = lookup(var.conditional_access_policy[count.index], "display_name")
  state        = lookup(var.conditional_access_policy[count.index], "state")

  dynamic "conditions" {
    for_each = try(lookup(var.conditional_access_policy[count.index], "conditions") == null ? [] : ["conditions"])
    content {
      client_app_types              = lookup(conditions.value, "client_app_types")
      service_principal_risk_levels = lookup(conditions.value, "service_principal_risk_levels")
      sign_in_risk_levels           = lookup(conditions.value, "sign_in_risk_levels")
      user_risk_levels              = lookup(conditions.value, "user_risk_levels")

      dynamic "applications" {
        for_each = try(lookup(conditions.value, "applications") == null ? [] : ["applications"])
        iterator = app
        content {
          excluded_applications = lookup(app.value, "excluded_applications")
          included_applications = lookup(app.value, "included_user_actions") != null ? null : lookup(app.value, "included_applications")
          included_user_actions = lookup(app.value, "included_applications") != null ? null : lookup(app.value, "included_user_actions")
        }
      }
      dynamic "client_applications" {
        for_each = try(lookup(conditions.value, "client_applications") == null ? [] : ["client_applications"])
        iterator = cli
        content {
          excluded_service_principals = lookup(cli.value, "excluded_service_principals")
          included_service_principals = lookup(cli.value, "included_service_principals")
        }
      }
      dynamic "devices" {
        for_each = try(lookup(conditions.value, "devices") == null ? [] : ["devices"])
        iterator = dev
        content {
          dynamic "filter" {
            for_each = try(lookup(dev.value, "filter") == null ? [] : ["filter"])
            content {
              mode = lookup(filter.value, "mode")
              rule = lookup(filter.value, "rule")
            }
          }
        }
      }
      dynamic "locations" {
        for_each = try(lookup(conditions.value, "locations") == null ? [] : ["locations"])
        iterator = loc
        content {
          included_locations = lookup(loc.value, "included_locations")
          excluded_locations = lookup(loc.value, "excluded_locations")

        }
      }
      dynamic "platforms" {
        for_each = try(lookup(conditions.value, "platforms") == null ? [] : ["platforms"])
        iterator = pla
        content {
          included_platforms = lookup(pla.value, "included_platforms")
          excluded_platforms = lookup(pla.value, "excluded_platforms")
        }
      }
      dynamic "users" {
        for_each = try(lookup(conditions.value, "users") == null ? [] : ["users"])
        content {
          excluded_groups = lookup(users.value, "excluded_groups")
          excluded_roles  = lookup(users.value, "excluded_roles")
          excluded_users  = lookup(users.value, "excluded_users")
          included_groups = lookup(users.value, "included_groups")
          included_roles  = lookup(users.value, "included_roles")
          included_users  = lookup(users.value, "included_users")

          dynamic "excluded_guests_or_external_users" {
            for_each = try(lookup(users.value, "excluded_guests_or_external_users") == null ? [] : ["excluded_guests_or_external_users"])
            iterator = ex
            content {
              guest_or_external_user_types = lookup(ex.value, "guest_or_external_user_types")

              dynamic "external_tenants" {
                for_each = try(lookup(ex.value, "external_tenants") == null ? [] : ["external_tenants"])
                iterator = ext
                content {
                  membership_kind = lookup(ext.value, "membership_kind")
                  members         = lookup(ext.value, "members")
                }
              }
            }
          }

          dynamic "included_guests_or_external_users" {
            for_each = try(lookup(users.value, "included_guests_or_external_users") == null ? [] : ["included_guests_or_external_users"])
            iterator = ex
            content {
              guest_or_external_user_types = lookup(ex.value, "guest_or_external_user_types")

              dynamic "external_tenants" {
                for_each = try(lookup(ex.value, "external_tenants") == null ? [] : ["external_tenants"])
                iterator = ext
                content {
                  membership_kind = lookup(ext.value, "membership_kind")
                  members         = lookup(ext.value, "members")
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "grant_controls" {
    for_each = try(lookup(var.conditional_access_policy[count.index], "grant_controls") == null ? [] : ["grant_controls"])
    iterator = grant
    content {
      operator                          = lookup(grant.value, "operator")
      authentication_strength_policy_id = lookup(grant.value, "authentication_strength_policy_id")
      built_in_controls                 = lookup(grant.value, "built_in_controls")
      custom_authentication_factors     = lookup(grant.value, "custom_authentication_factors")
      terms_of_use                      = lookup(grant.value, "terms_of_use")
    }
  }

  dynamic "session_controls" {
    for_each = try(lookup(var.conditional_access_policy[count.index], "session_controls") == null ? [] : ["session_controls"])
    iterator = session
    content {
      application_enforced_restrictions_enabled = lookup(session.value, "application_enforced_restrictions_enabled")
      cloud_app_security_policy                 = lookup(session.value, "cloud_app_security_policy")
      disable_resilience_defaults               = lookup(session.value, "disable_resilience_defaults")
      persistent_browser_mode                   = lookup(session.value, "persistent_browser_mode")
      sign_in_frequency                         = lookup(session.value, "sign_in_frequency")
      sign_in_frequency_authentication_type     = lookup(session.value, "sign_in_frequency_authentication_type")
      sign_in_frequency_interval                = lookup(session.value, "sign_in_frequency_interval")
      sign_in_frequency_period                  = lookup(session.value, "sign_in_frequency_period")
    }
  }
}

resource "azuread_named_location" "this" {
  count        = length(var.named_location)
  display_name = lookup(var.named_location[count.index], "display_name")

  dynamic "country" {
    for_each = try(lookup(var.named_location[count.index], "country") == null ? [] : ["country"])
    content {
      countries_and_regions                 = lookup(country.value, "countries_and_regions")
      include_unknown_countries_and_regions = lookup(country.value, "include_unknown_countries_and_regions")
    }
  }

  dynamic "ip" {
    for_each = try(lookup(var.named_location[count.index], "ip") == null ? [] : ["ip"])
    content {
      ip_ranges = lookup(ip.value, "ip_ranges")
      trusted   = lookup(ip.value, "trusted")
    }
  }
}

resource "azuread_service_principal_delegated_permission_grant" "this" {
  count                                = length(var.service_principal) == 0 ? 0 : length(var.service_principal_delegated_permission_grant)
  claim_values                         = lookup(var.service_principal_delegated_permission_grant[count.index], "claim_values")
  resource_service_principal_object_id = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_delegated_permission_grant[count.index], "service_principal_id")))
  service_principal_object_id          = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_delegated_permission_grant[count.index], "service_principal_id")))
  user_object_id                       = try(element(azuread_user.this.*.object_id, lookup(var.service_principal_delegated_permission_grant[count.index], "user_id")))
}

resource "azuread_custom_directory_role" "this" {
  count        = length(var.custom_directory_role)
  display_name = lookup(var.custom_directory_role[count.index], "display_name")
  enabled      = lookup(var.custom_directory_role[count.index], "enabled")
  version      = lookup(var.custom_directory_role[count.index], "version")
  description  = lookup(var.custom_directory_role[count.index], "description")
  #template_id  = ""

  dynamic "permissions" {
    for_each = lookup(var.custom_directory_role[count.index], "permissions")
    iterator = perm
    content {
      allowed_resource_actions = lookup(perm.value, "allowed_resource_actions")
    }
  }
}

resource "azuread_directory_role" "this" {
  count        = length(var.directory_role)
  display_name = lookup(var.directory_role[count.index], "display_name")
  template_id  = lookup(var.directory_role[count.index], "template_id")
}

resource "azuread_directory_role_assignment" "this" {
  count               = (length(var.user) && (length(var.directory_role) || length(var.custom_directory_role))) == 0 ? 0 : length(var.directory_role_assignment)
  principal_object_id = try(element(azuread_user.this.*.object_id, lookup(var.directory_role_assignment[count.index], "principal_object_id")))
  role_id = try(
    length(var.directory_role) != null ? element(azuread_directory_role.this.*.template_id, lookup(var.directory_role_assignment[count.index], "role_id")) :
    element(azuread_custom_directory_role.this.*.object_id, lookup(var.directory_role_assignment[count.index], "role_id"))
  )
  #app_scope_id        = ""
  directory_scope_id = format("/%s", try(element(azuread_application.this.*.object_id, lookup(var.directory_role_assignment[count.index], "application_id"))))
}

resource "azuread_directory_role_eligibility_schedule_request" "this" {
  count              = (length(var.user) && length(var.directory_role)) == 0 ? 0 : length(var.directory_role_eligibility_schedule_request)
  directory_scope_id = lookup(var.directory_role_eligibility_schedule_request[count.index], "directory_scope_id")
  justification      = lookup(var.directory_role_eligibility_schedule_request[count.index], "justification")
  principal_id       = try(element(azuread_user.this.*.object_id, lookup(var.directory_role_eligibility_schedule_request[count.index], "principal_id")))
  role_definition_id = try(element(azuread_directory_role.this.*.template_id, lookup(var.directory_role_eligibility_schedule_request[count.index], "role_definition_id")))
}

resource "azuread_directory_role_member" "this" {
  count            = length(var.directory_role_member)
  member_object_id = try(element(azuread_user.this.*.object_id, lookup(var.directory_role_member[count.index], "member_object_id")))
  role_object_id   = try(element(azuread_directory_role.this.*.object_id, lookup(var.directory_role_member[count.index], "role_object_id")))
}

resource "azuread_group" "this" {
  count                      = length(var.group)
  display_name               = lookup(var.group[count.index], "display_name")
  administrative_unit_ids    = lookup(var.group[count.index], "administrative_unit_ids")
  assignable_to_role         = lookup(var.group[count.index], "assignable_to_role")
  auto_subscribe_new_members = lookup(var.group[count.index], "auto_subscribe_new_members")
  behaviors                  = lookup(var.group[count.index], "behaviors")
  description                = lookup(var.group[count.index], "description")
  external_senders_allowed   = lookup(var.group[count.index], "external_senders_allowed")
  hide_from_address_lists    = lookup(var.group[count.index], "hide_from_address_lists")
  hide_from_outlook_clients  = lookup(var.group[count.index], "hide_from_outlook_clients")
  mail_enabled               = lookup(var.group[count.index], "mail_enabled")
  mail_nickname              = lookup(var.group[count.index], "mail_nickname")
  members                    = [try(element(azuread_user.this.*.object_id, lookup(var.group[count.index], "members")))]
  onpremises_group_type      = lookup(var.group[count.index], "onpremises_group_type")
  owners = [
    data.azuread_client_config.this.object_id,
    try(element(azuread_user.this.*.object_id, lookup(var.group[count.index], "user_id")))
  ]
  prevent_duplicate_names = lookup(var.group[count.index], "prevent_duplicate_names")
  provisioning_options    = lookup(var.group[count.index], "provisioning_options")
  security_enabled        = lookup(var.group[count.index], "security_enabled")
  theme                   = lookup(var.group[count.index], "theme")
  types                   = lookup(var.group[count.index], "types")
  visibility              = lookup(var.group[count.index], "visibility")
  writeback_enabled       = lookup(var.group[count.index], "writeback_enabled")

  dynamic "dynamic_membership" {
    for_each = lookup(var.group[count.index], "members") != null ? [] : lookup(var.group[count.index], "dynamic_membership")
    content {
      enabled = lookup(dynamic_membership.value, "enabled")
      rule    = lookup(dynamic_membership.value, "rule")
    }
  }
}

resource "azuread_group_member" "this" {
  count            = (length(var.group) && length(var.user)) == 0 ? 0 : length(var.group_member)
  group_object_id  = try(element(azuread_group.this.*.id, lookup(var.group_member[count.index], "group_object_id")))
  member_object_id = try(element(azuread_user.this.*.id, lookup(var.group_member[count.index], "member_object_id")))
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