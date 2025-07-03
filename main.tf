terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
resource "aws_instance" "app_server" {
  ami                         = "ami-05f991c49d264708f"
  instance_type               = "t2.micro"
  key_name                    = "iac-alura"
  associate_public_ip_address = true

  # Security Group já existente com porta 80 liberada
  vpc_security_group_ids = ["sg-06f9a2e2281790875"]

user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx

# Remove a página padrão
#sudo rm -f /var/www/html/index.nginx-debian.html
# Cria seu index.html personalizado
#echo "<h1>Feito com Terraform </h1>" | sudo tee /var/www/html/index.html
# Reinicia o Nginx para garantir que tudo está rodando

sudo systemctl enable nginx
sudo systemctl restart nginx
EOF
  tags = {
    Name = "Teste AWS 6"
  }
}