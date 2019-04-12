output "s3_bucket_name" {
  description = "Name of created S3 Bucket"
  value       = "${module.this.s3_bucket_id}"
}

output "dynamodb_table_name" {
  description = "Name of created DynamoDB Table"
  value       = "${module.this.dynamodb_table_name}"
}

output "tf_backend_config" {
  description = "Rendered backend config file"
  value       = "${module.this.terraform_backend_config}"
}
