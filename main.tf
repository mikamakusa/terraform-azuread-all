## ADMINISTRATIVE UNITS

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

## APP ROLE ASSIGNMENTS

resource "azuread_app_role_assignment" "this" {
  count               = length(var.service_principal) == 0 ? 0 : length(var.app_role_assignment)
  app_role_id         = try(element(azuread_service_principal.this.*.app_role_ids, lookup(var.app_role_assignment[count.index], "app_role_id")))
  principal_object_id = try(element(azuread_service_principal.this.*.object_id, lookup(var.app_role_assignment[count.index], "principal_object_id")))
  resource_object_id  = try(element(azuread_service_principal.this.*.object_id, lookup(var.app_role_assignment[count.index], "resource_object_id")))
}

## APPLICATIONS

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
  value          = length(var.certificate) != null ? try(element(module.keyvault.*.certificate_attribute_data, lookup(var.application_certificate[count.index], "certificate_id"))) : file(join("/", [path.cwd, "certificates", lookup(var.application_certificate[count.index], "value")]))
  application_id = try(element(azuread_application.this.*.id, lookup(var.application_certificate[count.index], "application_id")))
  type           = lookup(var.application_certificate[count.index], "type")
  encoding       = lookup(var.application_certificate[count.index], "encoding")
  end_date       = length(var.certificate) != null ? try(element(module.keyvault.*.certificate_attribute_expires, lookup(var.application_certificate[count.index], "certificate_id"))) : lookup(var.application_certificate[count.index], "end_date")
  start_date     = length(var.certificate) != null ? try(element(module.keyvault.*.certificate_attribute_not_before, lookup(var.application_certificate[count.index], "certificate_id"))) : lookup(var.application_certificate[count.index], "start_date")
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

## CONDITIONAL ACCESS

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

## DELETEGATED PERMISSION GRANT

resource "azuread_service_principal_delegated_permission_grant" "this" {
  count                                = length(var.service_principal) == 0 ? 0 : length(var.service_principal_delegated_permission_grant)
  claim_values                         = lookup(var.service_principal_delegated_permission_grant[count.index], "claim_values")
  resource_service_principal_object_id = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_delegated_permission_grant[count.index], "service_principal_id")))
  service_principal_object_id          = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_delegated_permission_grant[count.index], "service_principal_id")))
  user_object_id                       = try(element(azuread_user.this.*.object_id, lookup(var.service_principal_delegated_permission_grant[count.index], "user_id")))
}

## DIRECTORY ROLE

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

## GROUPS

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

## IDENTITY GOVERNANCE

resource "azuread_access_package" "this" {
  count        = length(var.access_package_catalog) == 0 ? 0 : length(var.access_package)
  catalog_id   = try(element(azuread_access_package_catalog.this.*.id, lookup(var.access_package[count.index], "catalog_id")))
  description  = lookup(var.access_package_catalog[count.index], "description")
  display_name = lookup(var.access_package_catalog[count.index], "display_name")
  hidden       = lookup(var.access_package_catalog[count.index], "hidden")
}

resource "azuread_access_package_assignment_policy" "this" {
  count             = length(var.access_package) == 0 ? 0 : length(var.access_package_assignment_policy)
  access_package_id = try(element(azuread_access_package.this.*.id, lookup(var.access_package_assignment_policy[count.index], "access_package_id")))
  description       = lookup(var.access_package_assignment_policy[count.index], "description")
  display_name      = lookup(var.access_package_assignment_policy[count.index], "display_name")
  duration_in_days  = lookup(var.access_package_assignment_policy[count.index], "duration_in_days")
  expiration_date   = lookup(var.access_package_assignment_policy[count.index], "expiration_date")
  extension_enabled = lookup(var.access_package_assignment_policy[count.index], "extension_enabled")

  dynamic "approval_settings" {
    for_each = try(lookup(var.access_package_assignment_policy[count.index], "approval_settings") == null ? [] : ["approval_settings"])
    iterator = approval
    content {
      approval_required                = lookup(approval.value, "approval_required")
      approval_required_for_extension  = lookup(approval.value, "approval_required_for_extension")
      requestor_justification_required = lookup(approval.value, "requestor_justification_required")

      dynamic "approval_stage" {
        for_each = try(lookup(approval.value, "approval_stage") == null ? [] : ["approval_stage"])
        iterator = stage
        content {
          approval_timeout_in_days            = lookup(stage.value, "approval_timeout_in_days")
          alternative_approval_enabled        = lookup(stage.value, "alternative_approval_enabled")
          approver_justification_required     = lookup(stage.value, "approver_justification_required")
          enable_alternative_approval_in_days = lookup(stage.value, "enable_alternative_approval_in_days")

          dynamic "alternative_approver" {
            for_each = try(lookup(stage.value, "alternative_approver") == null ? [] : ["alternative_approver"])
            iterator = alt
            content {
              subject_type = lookup(alt.value, "subject_type")
              backup       = lookup(alt.value, "backup")
              object_id    = element(azuread_group.this.*.object_id, lookup(alt.value, "object_id"))
            }
          }

          dynamic "primary_approver" {
            for_each = try(lookup(stage.value, "primary_approver") == null ? [] : ["primary_approver"])
            iterator = pri
            content {
              subject_type = lookup(pri.value, "subject_type")
              backup       = lookup(pri.value, "backup")
              object_id    = element(azuread_group.this.*.object_id, lookup(pri.value, "object_id"))
            }
          }
        }
      }
    }
  }

  dynamic "assignment_review_settings" {
    for_each = try(lookup(var.access_package_assignment_policy[count.index], "assignment_review_settings") == null ? [] : ["assignment_review_settings"])
    iterator = review
    content {
      access_recommendation_enabled   = lookup(review.value, "access_recommendation_enabled")
      access_review_timeout_behavior  = lookup(review.value, "access_review_timeout_behavior")
      approver_justification_required = lookup(review.value, "approver_justification_required")
      duration_in_days                = lookup(review.value, "duration_in_days")
      enabled                         = lookup(review.value, "enabled")
      review_frequency                = lookup(review.value, "review_frequency")
      review_type                     = lookup(review.value, "review_type")
      starting_on                     = lookup(review.value, "starting_on")

      dynamic "reviewer" {
        for_each = try(lookup(review.value, "reviewer") == null ? [] : ["reviewer"])
        iterator = rev
        content {
          subject_type = lookup(rev.value, "subject_type")
          backup       = lookup(rev.value, "backup")
          object_id    = try(element(azuread_group.this.*.object_id, lookup(rev.value, "object_id")))
        }
      }
    }
  }

  dynamic "question" {
    for_each = try(lookup(var.access_package_assignment_policy[count.index], "question") == null ? [] : ["question"])
    content {
      required = lookup(question.value, "required")
      sequence = lookup(question.value, "sequence")

      dynamic "choice" {
        for_each = try(lookup(question.value, "choice") == null ? [] : ["choice"])
        content {
          actual_value = lookup(choice.value, "actual_value")

          dynamic "display_value" {
            for_each = try(lookup(choice.value, "display_value") == null ? [] : ["display_value"])
            iterator = val
            content {
              default_text = lookup(val.value, "default_text")

              dynamic "localized_text" {
                for_each = try(lookup(val.value, "localized_text") == null ? [] : ["localized_text"])
                iterator = loc
                content {
                  content       = lookup(loc.value, "content")
                  language_code = lookup(loc.value, "language_code")
                }
              }
            }
          }
        }
      }

      dynamic "text" {
        for_each = try(lookup(question.value, "text") == null ? [] : ["text"])
        content {
          default_text = lookup(text.value, "default_text")

          dynamic "localized_text" {
            for_each = try(lookup(text.value, "localized_text") == null ? [] : ["localized_text"])
            iterator = loc
            content {
              content       = lookup(loc.value, "content")
              language_code = lookup(loc.value, "language_code")
            }
          }
        }
      }
    }
  }

  dynamic "requestor_settings" {
    for_each = try(lookup(var.access_package_assignment_policy[count.index], "requestor_settings") == null ? [] : ["requestor_settings"])
    iterator = request
    content {
      requests_accepted = lookup(request.value, "requests_accepted")
      scope_type        = lookup(request.value, "scope_type")

      dynamic "requestor" {
        for_each = try(lookup(request.value, "requestor") == null ? [] : ["requestor"])
        content {
          subject_type = lookup(requestor.value, "subject_type")
          object_id    = try(element(azuread_group.this.*.object_id, lookup(requestor.value, "object_id")))
        }
      }
    }
  }
}

resource "azuread_access_package_catalog" "this" {
  count              = length(var.access_package_catalog)
  description        = lookup(var.access_package_catalog[count.index], "description")
  display_name       = lookup(var.access_package_catalog[count.index], "display_name")
  externally_visible = lookup(var.access_package_catalog[count.index], "externally_visible")
  published          = lookup(var.access_package_catalog[count.index], "published")
}

resource "azuread_access_package_catalog_role_assignment" "this" {
  count               = (length(var.access_package_catalog) && length(var.user)) == 0 ? 0 : length(var.access_package_catalog_role_assignment)
  catalog_id          = try(element(azuread_access_package_catalog.this.*.id, lookup(var.access_package_catalog_role_assignment[count.index], "catalog_id")))
  principal_object_id = try(element(azuread_user.this.*.object_id, lookup(var.access_package_catalog_role_assignment[count.index], "principal_object_id")))
  role_id             = data.azuread_access_package_catalog_role.this.object_id
}

resource "azuread_access_package_resource_catalog_association" "this" {
  count                  = (length(var.access_package_catalog) && length(var.group)) == 0 ? 0 : length(var.access_package_resource_catalog_association)
  catalog_id             = try(element(azuread_access_package_catalog.this.*.id, lookup(var.access_package_resource_catalog_association[count.index], "catalog_id")))
  resource_origin_id     = try(element(azuread_group.this.*.object_id, lookup(var.access_package_resource_catalog_association[count.index], "resource_origin_id")))
  resource_origin_system = lookup(var.access_package_resource_catalog_association[count.index], "resource_origin_system")
}

resource "azuread_access_package_resource_package_association" "this" {
  count                           = (length(var.access_package) && length(var.access_package_resource_catalog_association)) == 0 ? 0 : length(var.access_package_resource_package_association)
  access_package_id               = try(element(azuread_access_package.this.*.id, lookup(var.access_package_resource_package_association[count.index], "access_package_id")))
  catalog_resource_association_id = try(element(azuread_access_package_resource_catalog_association.this.*.id, lookup(var.access_package_resource_package_association[count.index], "catalog_resource_association_id")))
  access_type                     = lookup(var.access_package_resource_package_association[count.index], "access_type", "Member")
}

resource "azuread_privileged_access_group_assignment_schedule" "this" {
  count                = (length(var.group) && length(var.user)) == 0 ? 0 : length(var.privileged_access_group_assignment_schedule)
  assignment_type      = lookup(var.privileged_access_group_assignment_schedule[count.index], "assignment_type")
  group_id             = try(element(azuread_group.this.*.id, lookup(var.privileged_access_group_assignment_schedule[count.index], "group_id")))
  principal_id         = try(element(azuread_user.this.*.id, lookup(var.privileged_access_group_assignment_schedule[count.index], "user_id")))
  justification        = lookup(var.privileged_access_group_assignment_schedule[count.index], "justification")
  ticket_number        = lookup(var.privileged_access_group_assignment_schedule[count.index], "ticket_number")
  ticket_system        = lookup(var.privileged_access_group_assignment_schedule[count.index], "ticket_system")
  start_date           = lookup(var.privileged_access_group_assignment_schedule[count.index], "start_date")
  expiration_date      = lookup(var.privileged_access_group_assignment_schedule[count.index], "expiration_date")
  duration             = lookup(var.privileged_access_group_assignment_schedule[count.index], "duration")
  permanent_assignment = lookup(var.privileged_access_group_assignment_schedule[count.index], "permanent_assignment")
}

resource "azuread_privileged_access_group_eligibility_schedule" "this" {
  count                = (length(var.group) && length(var.user)) == 0 ? 0 : length(var.privileged_access_group_eligibility_schedule)
  assignment_type      = lookup(var.privileged_access_group_eligibility_schedule[count.index], "assignment_type")
  group_id             = try(element(azuread_group.this.*.id, lookup(var.privileged_access_group_eligibility_schedule[count.index], "group_id")))
  principal_id         = try(element(azuread_user.this.*.id, lookup(var.privileged_access_group_eligibility_schedule[count.index], "user_id")))
  justification        = lookup(var.privileged_access_group_eligibility_schedule[count.index], "justification")
  ticket_number        = lookup(var.privileged_access_group_eligibility_schedule[count.index], "ticket_number")
  ticket_system        = lookup(var.privileged_access_group_eligibility_schedule[count.index], "ticket_system")
  start_date           = lookup(var.privileged_access_group_eligibility_schedule[count.index], "start_date")
  expiration_date      = lookup(var.privileged_access_group_eligibility_schedule[count.index], "expiration_date")
  duration             = lookup(var.privileged_access_group_eligibility_schedule[count.index], "duration")
  permanent_assignment = lookup(var.privileged_access_group_eligibility_schedule[count.index], "permanent_assignment")
}

resource "azuread_invitation" "this" {
  count              = length(var.invitation)
  redirect_url       = lookup(var.invitation[count.index], "redirect_url")
  user_email_address = lookup(var.invitation[count.index], "user_email_address")
  user_display_name  = lookup(var.invitation[count.index], "user_display_name")
  user_type          = lookup(var.invitation[count.index], "user_type")

  dynamic "message" {
    for_each = try(lookup(var.invitation[count.index], "message") == null ? [] : ["message"])
    content {
      additional_recipients = lookup(message.value, "additional_recipients")
      body                  = lookup(message.value, "language") != null ? null : lookup(message.value, "body")
      language              = lookup(message.value, "body") != null ? null : lookup(message.value, "language")
    }
  }
}

resource "azuread_authentication_strength_policy" "this" {
  count                = length(var.authentication_strength_policy)
  allowed_combinations = lookup(var.authentication_strength_policy[count.index], "allowed_combinations")
  display_name         = lookup(var.authentication_strength_policy[count.index], "display_name")
  description          = lookup(var.authentication_strength_policy[count.index], "description")
}

resource "azuread_claims_mapping_policy" "this" {
  count        = length(var.claims_mapping_policy)
  definition   = jsonencode(lookup(var.claims_mapping_policy[count.index], "definition"))
  display_name = lookup(var.claims_mapping_policy[count.index], "display_name")
}

resource "azuread_group_role_management_policy" "this" {
  count    = length(var.group) == 0 ? 0 : length(var.group_role_management_policy)
  group_id = try(element(azuread_group.this.*.id, lookup(var.group_role_management_policy[count.index], "group_id")))
  role_id  = lookup(var.group_role_management_policy[count.index], "role_id")

  dynamic "activation_rules" {
    for_each = try(lookup(var.group_role_management_policy[count.index], "activation_rules") == null ? [] : ["activation_rules"])
    iterator = act
    content {
      maximum_duration                                   = lookup(act.value, "maximum_duration")
      require_approval                                   = lookup(act.value, "require_approval")
      require_justification                              = lookup(act.value, "require_justification")
      require_multifactor_authentication                 = lookup(act.value, "require_multifactor_authentication")
      require_ticket_info                                = lookup(act.value, "require_ticket_info")
      required_conditional_access_authentication_context = lookup(act.value, "required_conditional_access_authentication_context")

      dynamic "approval_stage" {
        for_each = try(lookup(act.value, "approval_stage") == null ? [] : ["approval_stage"])
        iterator = app
        content {
          dynamic "primary_approver" {
            for_each = try(lookup(app.value, "primary_approver") == null ? [] : ["primary_approver"])
            iterator = pri
            content {
              object_id = try(element(azuread_group.this.*.object_id, lookup(pri.value, "object_id")))
              type      = lookup(pri.value, "type")
            }
          }
        }
      }
    }
  }

  dynamic "active_assignment_rules" {
    for_each = try(lookup(var.group_role_management_policy[count.index], "active_assignment_rules") == null ? [] : ["active_assignment_rules"])
    iterator = assi
    content {
      expiration_required                = lookup(assi.value, "expiration_required")
      expire_after                       = lookup(assi.value, "expire_after")
      require_justification              = lookup(assi.value, "require_justification")
      require_multifactor_authentication = lookup(assi.value, "require_multifactor_authentication")
      require_ticket_info                = lookup(assi.value, "require_ticket_info")
    }
  }

  dynamic "eligible_assignment_rules" {
    for_each = try(lookup(var.group_role_management_policy[count.index], "eligible_assignment_rules") == null ? [] : ["eligible_assignment_rules"])
    iterator = eli
    content {
      expiration_required = lookup(eli.value, "expiration_required")
      expire_after        = lookup(eli.value, "expire_after")
    }
  }

  dynamic "notification_rules" {
    for_each = try(lookup(var.group_role_management_policy[count.index], "notification_rules") == null ? [] : ["notification_rules"])
    iterator = not
    content {
      dynamic "active_assignments" {
        for_each = try(lookup(not.value, "active_assignments") == null ? [] : ["active_assignments"])
        iterator = act
        content {
          dynamic "admin_notifications" {
            for_each = try(lookup(act.value, "admin_notifications") == null ? [] : ["admin_notifications"])
            iterator = admin
            content {
              default_recipients    = lookup(admin.value, "default_recipients")
              notification_level    = lookup(admin.value, "notification_level")
              additional_recipients = lookup(admin.value, "additional_recipients")
            }
          }
          dynamic "approver_notifications" {
            for_each = try(lookup(act.value, "approver_notifications") == null ? [] : ["approver_notifications"])
            iterator = approver
            content {
              default_recipients    = lookup(approver.value, "default_recipients")
              notification_level    = lookup(approver.value, "notification_level")
              additional_recipients = lookup(approver.value, "additional_recipients")
            }
          }
          dynamic "assignee_notifications" {
            for_each = try(lookup(act.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = assignee
            content {
              default_recipients    = lookup(assignee.value, "default_recipients")
              notification_level    = lookup(assignee.value, "notification_level")
              additional_recipients = lookup(assignee.value, "additional_recipients")
            }
          }
        }
      }

      dynamic "eligible_activations" {
        for_each = try(lookup(not.value, "eligible_activations") == null ? [] : ["eligible_activations"])
        iterator = eli
        content {
          dynamic "admin_notifications" {
            for_each =  try(lookup(eli.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = admin
            content {
              default_recipients    = lookup(admin.value, "default_recipients")
              notification_level    = lookup(admin.value, "notification_level")
              additional_recipients = lookup(admin.value, "additional_recipients")
            }
          }
          dynamic "approver_notifications" {
            for_each =  try(lookup(eli.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = approver
            content {
              default_recipients    = lookup(approver.value, "default_recipients")
              notification_level    = lookup(approver.value, "notification_level")
              additional_recipients = lookup(approver.value, "additional_recipients")
            }
          }
          dynamic "assignee_notifications" {
            for_each =  try(lookup(eli.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = assignee
            content {
              default_recipients    = lookup(assignee.value, "default_recipients")
              notification_level    = lookup(assignee.value, "notification_level")
              additional_recipients = lookup(assignee.value, "additional_recipients")
            }
          }
        }
      }

      dynamic "eligible_assignments" {
        for_each = try(lookup(not.value, "eligible_assignments") == null ? [] : ["eligible_assignments"])
        iterator = ess
        content {
          dynamic "admin_notifications" {
            for_each = try(lookup(ess.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = admin
            content {
              default_recipients    = lookup(admin.value, "default_recipients")
              notification_level    = lookup(admin.value, "notification_level")
              additional_recipients = lookup(admin.value, "additional_recipients")
            }
          }
          dynamic "approver_notifications" {
            for_each = try(lookup(ess.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = approver
            content {
              default_recipients    = lookup(approver.value, "default_recipients")
              notification_level    = lookup(approver.value, "notification_level")
              additional_recipients = lookup(approver.value, "additional_recipients")
            }
          }
          dynamic "assignee_notifications" {
            for_each = try(lookup(ess.value, "assignee_notifications") == null ? [] : ["assignee_notifications"])
            iterator = assignee
            content {
              default_recipients    = lookup(assignee.value, "default_recipients")
              notification_level    = lookup(assignee.value, "notification_level")
              additional_recipients = lookup(assignee.value, "additional_recipients")
            }
          }
        }
      }
    }
  }
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
  count                = length(var.service_principal) == 0 ? 0 : length(var.service_principal_certificate)
  service_principal_id = try(element(azuread_service_principal.this.*.id, ))
  value                = lookup(var.service_principal_certificate[count.index], "file_extension") == "pem" ? file(join("/", [path.cwd, "certificates", join(".", [lookup(var.service_principal_certificate[count.index], "value"), lookup(var.service_principal_certificate[count.index], "file_extension")])])) : base64encode(file(join("/", [path.cwd, "certificates", join(".", [lookup(var.service_principal_certificate[count.index], "value"), lookup(var.service_principal_certificate[count.index], "file_extension")])])))
  encoding             = lookup(var.service_principal_certificate[count.index], "encoding")
  end_date             = lookup(var.service_principal_certificate[count.index], "end_date")
  end_date_relative    = lookup(var.service_principal_certificate[count.index], "end_date_relative")
  key_id               = lookup(var.service_principal_certificate[count.index], "key_id")
  start_date           = lookup(var.service_principal_certificate[count.index], "start_date")
  type                 = lookup(var.service_principal_certificate[count.index], "type")
}

resource "azuread_service_principal_claims_mapping_policy_assignment" "this" {
  count                    = (length(var.service_principal) && length(var.claims_mapping_policy)) == 0 ? 0 : length(var.service_principal_claims_mapping_policy_assignment)
  claims_mapping_policy_id = try(element(azuread_claims_mapping_policy.this.*.id, lookup(var.service_principal_claims_mapping_policy_assignment[count.index], "claims_mapping_policy_id")))
  service_principal_id     = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_claims_mapping_policy_assignment[count.index], "service_principal_id")))
}

resource "azuread_service_principal_password" "this" {
  count                = length(var.service_principal) == 0 ? 0 : length(var.service_principal_password)
  service_principal_id = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_password[count.index], "service_principal_id")))
  end_date             = lookup(var.service_principal_password[count.index], "end_date")
  end_date_relative    = lookup(var.service_principal_password[count.index], "end_date_relative")
  rotate_when_changed  = lookup(var.service_principal_password[count.index], "rotate_when_changed")
  start_date           = lookup(var.service_principal_password[count.index], "start_date")
}

resource "azuread_service_principal_token_signing_certificate" "this" {
  count                = length(var.service_principal) == 0 ? 0 : length(var.service_principal_token_signing_certificate)
  service_principal_id = try(element(azuread_service_principal.this.*.id, lookup(var.service_principal_token_signing_certificate[count.index], "service_principal_id")))
  display_name         = lookup(var.service_principal_token_signing_certificate[count.index], "display_name")
  end_date             = lookup(var.service_principal_token_signing_certificate[count.index], "end_date")
}

resource "azuread_synchronization_job" "this" {
  count                = length(var.service_principal) == 0 ? 0 : length(var.synchronization_job)
  service_principal_id = try(element(azuread_service_principal.this.*.id, lookup(var.synchronization_job[count.index], "service_principal")))
  template_id          = lookup(var.synchronization_job[count.index], "template_id")
  enabled              = lookup(var.synchronization_job[count.index], "enabled")
}

resource "azuread_synchronization_job_provision_on_demand" "this" {
  count                  = (length(var.service_principal) && length(var.synchronization_job)) == 0 ? 0 : length(var.synchronization_job_provision_on_demand)
  service_principal_id   = try(element(azuread_service_principal.this.*.id, lookup(var.synchronization_job_provision_on_demand[count.index], "service_principal_id")))
  synchronization_job_id = try(element(azuread_synchronization_job.this.*.id, lookup(var.synchronization_job_provision_on_demand[count.index], "synchronization_job_id")))
  triggers               = lookup(var.synchronization_job_provision_on_demand[count.index], "trigger")

  dynamic "parameter" {
    for_each = lookup(var.synchronization_job_provision_on_demand[count.index], "parameter")
    content {
      rule_id = lookup(parameter.value, "role_id")

      dynamic "subject" {
        for_each = lookup(parameter.value, "subject")
        content {
          object_id        = element(azuread_group.this.*.object_id, lookup(subject.value, "group_id"))
          object_type_name = lookup(subject.value, "object_type_name")
        }
      }
    }
  }
}

resource "azuread_synchronization_secret" "this" {
  count                = length(var.service_principal) == 0 ? 0 : length(var.synchronization_secret)
  service_principal_id = try(element(azuread_service_principal.this.*.id, lookup(var.synchronization_secret, )))

  dynamic "credential" {
    for_each = lookup(var.synchronization_secret[count.index], "credentials")
    content {
      key   = lookup(credential.value, "key")
      value = lookup(credential.value, "value")
    }
  }
}

resource "azuread_user_flow_attribute" "this" {
  count        = length(var.user_flow_attribute)
  data_type    = lookup(var.user_flow_attribute[count.index], "data_type")
  description  = lookup(var.user_flow_attribute[count.index], "description")
  display_name = lookup(var.user_flow_attribute[count.index], "display_name")
}

resource "azuread_user" "this" {
  count                       = length(var.user)
  display_name                = lookup(var.user[count.index], "display_name")
  user_principal_name         = lookup(var.user[count.index], "user_principal_name")
  account_enabled             = lookup(var.user[count.index], "account_enabled")
  age_group                   = lookup(var.user[count.index], "age_group")
  business_phones             = lookup(var.user[count.index], "business_phones")
  city                        = lookup(var.user[count.index], "city")
  company_name                = lookup(var.user[count.index], "company_name")
  consent_provided_for_minor  = lookup(var.user[count.index], "consent_provided_for_minor")
  cost_center                 = lookup(var.user[count.index], "cost_center")
  country                     = lookup(var.user[count.index], "country")
  department                  = lookup(var.user[count.index], "department")
  disable_password_expiration = lookup(var.user[count.index], "disable_password_expiration")
  disable_strong_password     = lookup(var.user[count.index], "disable_strong_password")
  division                    = lookup(var.user[count.index], "division")
  employee_id                 = lookup(var.user[count.index], "employee_id")
  employee_type               = lookup(var.user[count.index], "employee_type")
  fax_number                  = lookup(var.user[count.index], "fax_number")
  force_password_change       = lookup(var.user[count.index], "force_password_change")
  given_name                  = lookup(var.user[count.index], "given_name")
  job_title                   = lookup(var.user[count.index], "job_title")
  mail                        = lookup(var.user[count.index], "mail")
  mail_nickname               = lookup(var.user[count.index], "mail_nickname")
  mobile_phone                = lookup(var.user[count.index], "mobile_phone")
  office_location             = lookup(var.user[count.index], "office_location")
  onpremises_immutable_id     = lookup(var.user[count.index], "onpremises_immutable_id")
  other_mails                 = lookup(var.user[count.index], "other_mails")
  password                    = lookup(var.user[count.index], "password")
  postal_code                 = lookup(var.user[count.index], "postal_code")
  preferred_language          = lookup(var.user[count.index], "preferred_language")
  show_in_address_list        = lookup(var.user[count.index], "show_in_address_list")
  state                       = lookup(var.user[count.index], "state")
  street_address              = lookup(var.user[count.index], "street_address")
  surname                     = lookup(var.user[count.index], "surname")
  usage_location              = lookup(var.user[count.index], "usage_location")
}