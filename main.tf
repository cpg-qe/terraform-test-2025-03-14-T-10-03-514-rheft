provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}


resource "azurerm_mssql_server" "example" {
  name                         = "${var.prefix}-sqlsvr${random_id.id.hex}"
  resource_group_name          = var.azure_rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd!"
}

resource "azurerm_mssql_database" "example" {
  name     = "${var.prefix}-db"
  server_id = azurerm_mssql_server.example.id  # Use the ID of the SQL Server

  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "Basic"  # Specify the SKU name for the database
}

resource "random_id" "id" {
  byte_length = 2
}
