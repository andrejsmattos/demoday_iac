# 1. Security Group para liberar a porta 80 (HTTP) para qualquer origem
resource "aws_security_group" "http_sg" {
  name        = "allow-http-sg"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "allow-http" }
}

# 2. Security Group para liberar a porta 22 (SSH) para um IP específico
resource "aws_security_group" "ssh_sg" {
  name        = "allow-ssh-sg"
  description = "Allow SSH from my IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.meu_ip_publico]
  }

  tags = { Name = "allow-ssh" }
}

# 3. Security Group para liberar a porta 3000 (Next.js) para qualquer origem
resource "aws_security_group" "nextjs_sg" {
  name        = "allow-nextjs-sg"
  description = "Allow Next.js port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "allow-nextjs" }
}

# 4. Security Group para liberar todo o tráfego de saída (Egress)
resource "aws_security_group" "egress_all_sg" {
  name        = "allow-all-egress-sg"
  description = "Allow all outbound traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "allow-all-egress" }
}