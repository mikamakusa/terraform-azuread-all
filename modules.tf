module "keyvault" {
  source              = "./modules/terraform-azure-keyvault"
  resource_group_name = var.resource_group_name
  certificate         = var.certificate
  key_vault           = var.keyvault
}