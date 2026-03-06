output "frontend_ip" {
  description = "IP Público da instância do Frontend"
  value       = aws_instance.frontend_server.public_ip
}

output "backend_ip" {
  description = "IP Público da instância do Backend"
  value       = aws_instance.backend_server.public_ip
}

output "frontend_url" {
  description = "Acesse o site aqui"
  value       = "http://${aws_instance.frontend_server.public_ip}:3000"
}

output "backend_docs_url" {
  description = "Acesse o Swagger da API aqui"
  value       = "http://${aws_instance.backend_server.public_ip}:8000/docs"
}