output "bucket_id" {
  description = "ID do bucket S3 criado"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "Domain name do bucket S3"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional domain name do bucket S3"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_region" {
  description = "Região AWS onde o bucket foi criado"
  value       = aws_s3_bucket.main.region
}

output "versioning_enabled" {
  description = "Status do versionamento do bucket"
  value       = aws_s3_bucket_versioning.main.versioning_configuration[0].status
}

output "encryption_algorithm" {
  description = "Algoritmo de criptografia utilizado"
  value       = "AES256"
}

output "public_access_blocked" {
  description = "Indica se o acesso público está bloqueado"
  value       = aws_s3_bucket_public_access_block.main.block_public_acls
}
