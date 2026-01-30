terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "moltbot_sg" {
  name        = "moltbot_sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "moltbot_server" {
  ami           = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = "moltbot-key" # MAKE SURE THIS KEY EXISTS IN AWS CONSOLE
  security_groups = [aws_security_group.moltbot_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              # 1. Create Swap (4GB) to prevent crashes
              fallocate -l 4G /swapfile
              chmod 600 /swapfile
              mkswap /swapfile
              swapon /swapfile
              echo '/swapfile none swap sw 0 0' >> /etc/fstab

              # 2. Install Node 22, Git, Python
              curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
              apt-get install -y nodejs git python3 python3-pip

              # 3. Install PM2
              npm install -g pm2

              # 4. Clone Repo & Install Moltbot
              cd /home/ubuntu
              git clone https://github.com/yashrmusic/moltbot-urbanmistrii.git
              cd moltbot-urbanmistrii
              npm install --omit=dev
              pip3 install -r requirements.txt --break-system-packages

              # 5. Set Environment Variables (REPLACE THESE WITH YOUR KEYS BEFORE APPYLING)
              echo 'export GEMINI_API_KEY="AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM"' >> /etc/profile
              echo 'export EMAIL_PASS_MAIL="Rr22081993!"' >> /etc/profile
              echo 'export EMAIL_PASS_HR="Rr22081993!"' >> /etc/profile
              
              # 6. Start with PM2
              pm2 start npm --name "moltbot" -- start
              pm2 save
              pm2 startup
              EOF

  tags = {
    Name = "Moltbot-Server"
  }
}

output "instance_ip" {
  value = aws_instance.moltbot_server.public_ip
}
