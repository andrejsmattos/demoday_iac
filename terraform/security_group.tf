# Porta 3000 (Exclusiva do Frontend)
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg-3000"
  description = "Allow Next.js traffic"
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Porta 8000 (Exclusiva do Backend)
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg-8000"
  description = "Allow FastAPI traffic"
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Porta 22 (SSH para o GitHub Actions entrar nas duas máquinas)
resource "aws_security_group" "ssh_sg" {
  name        = "github-actions-ssh"
  description = "Allow SSH from CI/CD"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

# Tráfego de saída livre para as duas máquinas baixarem imagens
resource "aws_security_group" "egress_all_sg" {
  name        = "allow-all-egress"
  description = "Allow all outbound traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}