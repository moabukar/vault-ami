packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


variable "aws_region" {
  default = "us-east-1"
}

variable "ami_name" {
  default = "vault-server-ami"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "source_ami" {
  default = "ami-090fa75af13c156b4" # Amazon Linux 2 (Change if using Ubuntu)
}

variable "ssh_username" {
  default = "ec2-user" # Use "ubuntu" for Ubuntu AMIs
}

# AWS Builder Configuration
source "amazon-ebs" "vault_ami" {
  region                      = var.aws_region
  source_ami                  = var.source_ami
  instance_type               = var.instance_type
  ssh_username                = var.ssh_username
  ami_name                    = var.ami_name
  ami_description             = "Pre-configured Vault AMI"
  associate_public_ip_address = true
  tags = {
    Name = "Vault AMI"
  }
}

# Provisioners (Runs the Vault install script)
build {
  sources = ["source.amazon-ebs.vault_ami"]

  provisioner "file" {
    source      = "install_vault.sh"
    destination = "/tmp/install_vault.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_vault.sh",
      "sudo /tmp/install_vault.sh"
    ]
  }
}
