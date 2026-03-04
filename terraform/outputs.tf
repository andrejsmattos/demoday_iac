output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "URL da aplicação Next.js"
  value       = "http://${aws_instance.web_server.public_ip}:3000"
}