resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key_pair.key_name

  subnet_id     = "subnet-0ad672b9ab7ae0df3"

  vpc_security_group_ids = [
    aws_security_group.http_sg.id,
    aws_security_group.ssh_sg.id,
    aws_security_group.nextjs_sg.id,
    aws_security_group.egress_all_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "DemoDay-Frontend"
  }
}