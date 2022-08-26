terraform {
  backend "azurerm" {
    resource_group_name = "rgvm"
    storage_account_name = "terraformcicd"
    container_name = "vmstorage"
    key = "terraform.vmstorage"
    access_key = "FRQOiiE1aoQExkbiQVcHhsfqbvlU3A8FEf6IJfBWn57TsKUBtYaIe3oQE7zVYyqIympdZQkKv1nL+AStVdIDxg=="
  }
}

provider "azurerm" {
    features {}
    subscription_id = "d1fa1e7d-96f9-49e2-a42a-ce2af2fcf648"
    client_id = "8c9429ae-0b26-42d3-b85d-56f59bd030cc"
    tenant_id = "5d2813b5-146f-4be4-9e49-0f9c7bf09d4b"
    client_secret = "hE08Q~ZGzqwPs6X8pf32WNzobvBb4a_9WOX8Hboq"  
}

locals {
  setup_name ="practice-hyd"
}
resource "azurerm_resource_group" "testrglabel" {
    name = "testrgeastus"
    location = "East US"
    tags = {
      "name" = "${local.setup_name}-rsg"
    }

  
}
resource "azurerm_app_service_plan" "testappplan" {
    name = "testappplansv"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    sku {
      tier = "standard"
      size = "S1"
    }
    depends_on = [
      azurerm_resource_group.testrglabel
    ]
    tags = {
      "name" = "${local.setup_name}-appplan"
    }
  
}

resource "azurerm_app_service" "testwebapp" {
    name = "testwebapp56886951"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    app_service_plan_id = azurerm_app_service_plan.testappplan.id
    tags = {
      "name" = "${local.setup_name}-webapp"
    }
    depends_on = [
      azurerm_app_service_plan.testappplan
    ]
  
}
