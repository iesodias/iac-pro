# AWS Configuration
aws_region  = "us-east-1"
environment = "dev"

# EC2 Configuration
instance_name    = "lab-ec2-basic"
instance_type    = "t3.micro"
allowed_ssh_cidr = "0.0.0.0/0"
key_pair_name    = null
root_volume_size = 30

# Tags
tags = {
  Owner      = "DevOps-Team"
  Project    = "Terraform-Labs"
  CostCenter = "Engineering"
}
