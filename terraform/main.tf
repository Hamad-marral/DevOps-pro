provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0b27735385ddf20e8"
  instance_type = "t2.micro"
  key_name      = "EC2_key_pair"  # Ensure this matches the name of the key pair in AWS

  tags = {
    Name = "example-instance"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ansible/configure_ec2.yml -i '${self.public_ip},' -u ubuntu --private-key=private_key"
  }
}
