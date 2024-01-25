terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.0.1"
    }
  }
}

provider "databricks" {
  host  = var.databricks_url
  token = var.workspace_PAT
}

# module "common" {
#   source             = "../common/"
#   account_console_id = var.account_console_id
#   workspace_id       = var.workspace_id
#   sqlw_id            = var.sqlw_id
# }
