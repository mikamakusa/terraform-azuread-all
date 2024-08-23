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

## SERVICE PRINCIPAL

output "service_principal_id" {
  value = try(
    azuread_service_principal.this.*.id
  )
}