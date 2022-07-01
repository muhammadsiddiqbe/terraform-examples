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
