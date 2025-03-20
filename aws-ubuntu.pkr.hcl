packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ubuntu-aws-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  ssh_username  = "ubuntu"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

}


build{
  provisioner "file" {
    source = "./cats/ok.txt"
    destination = "/home/ubuntu/ok.txt"
  }
  sources = ["source.amazon-ebs.ubuntu"]
}