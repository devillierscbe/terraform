resource "aws_instance" "web_instance" {
  ami                         = "ami-0be0a52ed3f231c12"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
}
