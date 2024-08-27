run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "azuread_administrative_unit_role_member" {
  command = plan

  variables {
    user = [{
      id                  = 0
      user_principal_name = "jdoe@hashicorp.com"
      display_name        = "J. Doe"
      mail_nickname       = "jdoe"
      password            = "SecretP@sswd99!"
    }]
    administrative_unit = [{
      id                        = 0
      display_name              = "Example-AU"
      description               = "Just an example"
      hidden_membership_enabled = false
    }]
    directory_role = [{
      id = 0
    }]
    administrative_unit_member = [{
      id                            = 0
      administrative_unit_object_id = 0
      member_object_id              = 0
    }]
    administrative_unit_role_member = [{
      id                            = 0
      role_object_id                = 0
      administrative_unit_object_id = 0
      member_object_id              = 0
    }]
  }
}

run "app_role_assignment" {
  command = plan

  variables {
    app_role_assignment = [{
      id = 0
      app_role_id         = 0
      principal_object_id = 1
      resource_object_id  = 0
    }]
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
    service_principal = [{
      id        = 0
      client_id = 0
      feature_tags = [
        {
          enterprise = true
          gallery    = true
        }
      ]
    },{
      id        = 1
      client_id = 0
      feature_tags = [
        {
          enterprise = true
          gallery    = true
        }
      ]
    }]
  }
}