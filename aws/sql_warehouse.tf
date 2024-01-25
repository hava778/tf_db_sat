resource "databricks_sql_endpoint" "new" {
  count            = var.sqlw_id == "new" ? 1 : 0
  name             = "SAT Warehouse"
  cluster_size     = "Small"
  max_num_clusters = 1

  tags {
    custom_tags {
      key   = "owner"
      value = data.databricks_current_user.me.alphanumeric
    }
  }
}

data "databricks_sql_warehouse" "new" {
  count = var.sqlw_id == "new" ? 0 : 1
  id    = var.sqlw_id
}


resource "databricks_cluster" "this" {
  cluster_name = "Exploration (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest.id
  instance_pool_id        = databricks_instance_pool.smallest_nodes.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 10
  }
}

resource "databricks_cluster_policy" "this" {
  name = "Minimal (${data.databricks_current_user.me.alphanumeric})"
  definition = jsonencode({
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    }
  })
}

resource "databricks_instance_pool" "smallest_nodes" {
  instance_pool_name = "Smallest Nodes (${data.databricks_current_user.me.alphanumeric})"
  min_idle_instances = 1
  max_capacity       = 1
  node_type_id       = data.databricks_node_type.smallest.id
  preloaded_spark_versions = [
    data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = 20
}

