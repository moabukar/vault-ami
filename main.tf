provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  default = "ami-010b1877662d8747c"
}

resource "aws_instance" "vault" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  key_name               = "vault-dev"
  vpc_security_group_ids = ["sg-06d59bbad808fc1ee"]


  tags = {
    Name = "Vault Server"
  }
}

output "vault_public_ip" {
  value = aws_instance.vault.public_ip
}

output "ssh_command" {
  description = "SSH into your Vault server"
  value       = format("ssh -i vault-dev.pem ec2-user@%s", aws_instance.vault.public_ip)
}
