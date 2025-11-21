output "instance_id" {
  description = "ID da instância EC2 criada"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Endereço IP público da instância"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "Endereço IP privado da instância"
  value       = aws_instance.main.private_ip
}

output "instance_public_dns" {
  description = "Hostname público da instância"
  value       = aws_instance.main.public_dns
}

output "security_group_id" {
  description = "ID do Security Group associado"
  value       = aws_security_group.ssh.id
}

output "ami_id" {
  description = "AMI utilizada para criar a instância"
  value       = data.aws_ami.amazon_linux.id
}
