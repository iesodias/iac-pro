# AWS Configuration
aws_region  = "us-east-1"
environment = "dev"

# S3 Bucket Configuration
bucket_name       = "terraform-lab-s3-basic-2025"
enable_versioning = true
force_destroy     = true

# Tags
tags = {
  Owner      = "DevOps-Team"
  Project    = "Terraform-Labs"
  CostCenter = "Engineering"
}
