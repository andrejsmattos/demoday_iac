output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "URL da aplicação Next.js"
  value       = "http://${aws_instance.web_server.public_ip}:3000"
}

output "EC2_HOST" {
  description = "IP do servidor EC2 para conexão"
  value       = aws_instance.web_server.public_ip
  sensitive   = false
}

output "EC2_USERNAME" {
  description = "Usuário padrão do servidor EC2"
  value       = var.ec2_username
  sensitive   = false
}

output "EC2_SSH_KEY" {
  description = "Caminho da chave privada SSH para acessar o servidor"
  value       = "${path.module}/keys/${aws_key_pair.ec2_key_pair.key_name}.pem"
  sensitive   = true
}