data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "osrm-sec-gr" {
  name = "osrm-sec-gr"

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "osrm" {
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.osrm-sec-gr.id]

  tags = {
    Name = "osrm"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/${var.key_name}.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "osrm/"
    destination = "/home/ubuntu" 
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y docker.io docker-compose-plugin",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo docker compose -f /home/ubuntu/docker-compose.yaml up -d",
    ]
  }
}
