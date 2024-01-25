output "secret_scope_id" {
  value       = databricks_secret_scope.sat.id
  description = "ID of the created secret scope to add more secrets if necessary"
}

output "notebook_url" {
 value = databricks_notebook.this.url
}

output "notebook_url" {
  value = databricks_notebook.this.url
}

output "job_url" {
  value = databricks_job.this.url
}