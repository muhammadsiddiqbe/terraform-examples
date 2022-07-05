terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id = "f5e76248-4a36-46c4-a53a-399f94f9e210"
}

resource "azurerm_resource_group" "aks-rg2" {
  name     = "my-terraform-gr"
  location = "Central US"

  tags = {
    "environment" = "k8sdev"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "first-key-vault" {
  name                        = "my-second-vault"
  location                    = azurerm_resource_group.aks_rg.location
  resource_group_name         = azurerm_resource_group.aks_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = ""

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]

    storage_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]
  }
}

resource "azurerm_key_vault_secret" "my-secret" {
  name         = "sirli-masalliq"
  value        = "uning-ozi-yoq"
  key_vault_id = azurerm_key_vault.first-key-vault.id
}