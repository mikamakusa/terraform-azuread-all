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

output "application_identifier_uri_id" {
  value = try(
    azuread_application_identifier_uri.this.*.id
  )
}

## APPLICATION KNOWN CLIENTS

output "application_known_clients_id" {
  value = try(
    azuread_application_known_clients.this.*.id
  )
}

## APPLICATION OPTIONAL CLAIMS

output "application_optional_claims_id" {
  value = try(
    azuread_application_optional_claims.this.*.id
  )
}

## APPLICATION OWNER

output "application_owner_id" {
  value = try(
    azuread_application_owner.this.*.id
  )
}

## APPLICATION PASSWORD

output "application_password_id" {
  value = try(
    azuread_application_password.this.*.id
  )
}

## APPLICATION PERMISSION SCOPE

output "application_permission_scope_id" {
  value = try(
    azuread_application_permission_scope.this.*.id
  )
}

## APPLICATION REDIRECT URIS

output "application_redirect_uris_id" {
  value = try(
    azuread_application_redirect_uris.this.*.id
  )
}

## APPLICATION REGISTRATION

output "application_registration_id" {
  value = try(
    azuread_application_registration.this.*.id
  )
}

## CONDITIONAL ACCESS POLICY

output "conditional_access_policy_id" {
  value = try(
    azuread_conditional_access_policy.this.*.id
  )
}

output "conditional_access_policy_display_name" {
  value = try(
    azuread_conditional_access_policy.this.*.display_name
  )
}

## NAMED LOCATION

output "named_location_id" {
  value = try(
    azuread_named_location.this.*.id
  )
}

## DELEGATED PERMISSION GRANTS

output "service_principal_delegated_permission_grant_id" {
  value = try(
    azuread_service_principal_delegated_permission_grant.this.*.id
  )
}

## DIRECTORY ROLE TEMPLATES

output "custom_directory_role_id" {
  value = try(
    azuread_custom_directory_role.this.*.id
  )
}

output "directory_role_id" {
  value = try(
    azuread_directory_role.this.*.id
  )
}

output "directory_role_object_id" {
  value = try(
    azuread_directory_role.this.*.object_id
  )
}

output "directory_role_assignment_id" {
  value = try(
    azuread_directory_role_assignment.this.*.id
  )
}

output "directory_role_eligibility_schedule_request_id" {
  value = try(
    azuread_directory_role_eligibility_schedule_request.this.*.id
  )
}

output "directory_role_member_id" {
  value = try(
    azuread_directory_role_member.this.*.id
  )
}

## GROUP

output "group_id" {
  value = try(
    azuread_group.this.*.id
  )
}

output "group_member_id" {
  value = try(
    azuread_group_member.this.*.id
  )
}

## IDENTITY GOVERNANCE

output "access_package_id" {
  value = try(
    azuread_access_package.this.*.id
  )
}

output "access_package_assignment_policy_id" {
  value = try(
    azuread_access_package_assignment_policy.this.*.id
  )
}

output "access_package_catalog_id" {
  value = try(
    azuread_access_package_catalog.this.*.id
  )
}

output "access_package_catalog_role_assignment_id" {
  value = try(
    azuread_access_package_catalog_role_assignment.this.*.id
  )
}

output "access_package_resource_catalog_association_id" {
  value = try(
    azuread_access_package_resource_catalog_association.this.*.id
  )
}

output "access_package_resource_package_association_id" {
  value = try(
    azuread_access_package_resource_package_association.this.*.id
  )
}

output "privileged_access_group_assignment_schedule_id" {
  value = try(
    azuread_privileged_access_group_eligibility_schedule.this.*.id
  )
}

output "privileged_access_group_eligibility_schedule_id" {
  value = try(
    azuread_privileged_access_group_assignment_schedule.this.*.id
  )
}

## INVITATION

output "invitation_id" {
  value = try(
    azuread_invitation.this.*.id
  )
}

##POLICIES

output "authentication_strength_policy_id" {
  value = try(
    azuread_authentication_strength_policy.this.*.id
  )
}

output "claims_mapping_policy_id" {
  value = try(
    azuread_claims_mapping_policy.this.*.id
  )
}

output "group_role_management_policy_id" {
  value = try(
    azuread_group_role_management_policy.this.*.id
  )
}

## SERVICE PRINCIPALS

output "service_principal_certificate_id" {
  value = try(
    azuread_service_principal_certificate.this.*.id
  )
}

output "service_principal_claims_mapping_policy_assignment_id" {
  value = try(
    azuread_service_principal_claims_mapping_policy_assignment.this.*.id
  )
}

output "service_principal_id" {
  value = try(
    azuread_service_principal.this.*.id
  )
}

output "service_principal_app_roles" {
  value = try(
    azuread_service_principal.this.*.app_roles
  )
}

output "service_principal_permission_scopes" {
  value = try(
    azuread_service_principal.this.*.oauth2_permission_scopes
  )
}

output "service_principal_password" {
  value = try(
    azuread_service_principal_password.this.*.id
  )
}

output "service_principal_token_signing_certificate" {
  value = try(
    azuread_service_principal_token_signing_certificate.this.*.id
  )
}

## SYNCHRONIZATION

output "synchronization_job" {
  value = try(
    azuread_synchronization_job.this.*.id
  )
}

output "synchronization_job_provision_on_demand" {
  value = try(
    azuread_synchronization_job_provision_on_demand.this.*.id
  )
}

output "synchronization_secret" {
  value = try(
    azuread_synchronization_secret.this.*.id
  )
}

## USER FLOWS

output "user_flow_attribute" {
  value = try(
    azuread_user_flow_attribute.this.*.id
  )
}

## USER

output "user" {
  value = try(
    azuread_user.this.*.id
  )
}
