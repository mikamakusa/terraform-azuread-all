## ADMINISTRATIVE UNIT

output "administrative_unit_display_name" {
  value = try(
    azuread_administrative_unit.this.*.display_name
  )
}

output "administrative_unit_id" {
  value = try(
    azuread_administrative_unit.this.*.id
  )
}

## ADMINISTRATIVE UNIT MEMBER

output "administrative_unit_member_id" {
  value = try(
    azuread_administrative_unit_member.this.*.id
  )
}

output "administrative_unit_object_id" {
  value = try(
    azuread_administrative_unit_member.this.*.administrative_unit_object_id
  )
}

## ADMINISTRATIVE UNIT ROLE MEMBER

output "administrative_unit_role_member_id" {
  value = try(
    azuread_administrative_unit_role_member.this.*.id
  )
}

## APPLICATION

output "application_id" {
  value = try(
    azuread_application.this.*.id
  )
}

output "application_display_name" {
  value = try(
    azuread_application.this.*.display_name
  )
}

## APPLICATION APP ROLE

output "application_app_role_id" {
  value = try(
    azuread_application_app_role.this.*.id
  )
}

output "application_app_role_display_name" {
  value = try(
    azuread_application_app_role.this.*.display_name
  )
}

##APPLICATION_CERTIFICATE

output "application_certificate_id" {
  value = try(
    azuread_application_certificate.this.*.id
  )
}

## APPLICATION FALLBACK PUBLIC CLIENT

output "application_fallback_public_client_id" {
  value = try(
    azuread_application_fallback_public_client.this.*.id
  )
}

## APPLICATION FEDERATED IDENTITY CREDENTIAL

output "application_federated_identity_credential_id" {
  value = try(
    azuread_application_federated_identity_credential.this.*.id
  )
}

output "application_federated_identity_credential_credential_id" {
  value = try(
    azuread_application_federated_identity_credential.this.*.credential_id
  )
}

## APPLICATION FROM TEMPLATE

output "application_from_template_id" {
  value = try(
    azuread_application_from_template.this.*.id
  )
}

output "application_from_template_display_name" {
  value = try(
    azuread_application_from_template.this.*.display_name
  )
}

## APPLICATION IDENTIFIER URI

## SERVICE PRINCIPAL

output "service_principal_id" {
  value = try(
    azuread_service_principal.this.*.id
  )
}