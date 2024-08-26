data "azuread_client_config" "this" {}

data "azuread_application_template" "this" {
  count        = var.application_template_display_name ? 1 : 0
  display_name = var.application_template_display_name
}

data "azuread_application_published_app_ids" "this" {}

data "azuread_access_package_catalog_role" "this" {}