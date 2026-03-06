# Máquina 1: O Frontend (Next.js)
resource "aws_instance" "frontend_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key_pair.key_name
  
  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id,
    aws_security_group.ssh_sg.id,
    aws_security_group.egress_all_sg.id
  ]
  associate_public_ip_address = true
  tags = { Name = "DemoDay-Frontend" }
}

# Máquina 2: O Backend (FastAPI)
resource "aws_instance" "backend_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key_pair.key_name
  
  vpc_security_group_ids = [
    aws_security_group.backend_sg.id,
    aws_security_group.ssh_sg.id,
    aws_security_group.egress_all_sg.id
  ]
  associate_public_ip_address = true
  tags = { Name = "DemoDay-Backend" }
}