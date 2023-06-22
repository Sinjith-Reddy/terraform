data "aws_ami" "ubuntu" {
    owners = [ "ubuntu" ]
    most_recent = true
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.*" ]  # ubuntu latest 
    }
  
}
data "aws_ami" "AWSLinux" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = [ "al2023-ami-2023.0.20230614.0-kernel-*" ] # Amazon Linux 2023
    }
  
}
#----------------------------------------
#EC2 instance for Jenkins Master
#----------------------------------------
resource "aws_instance" "Jenkins-master" {
    ami                       = data.aws_ami.ubuntu.id
    instance_type             = var.instance
    availability_zone         = var.ZONE
    key_name                  = "terraKey" # key to ssh to server
    vpc_security_group_ids    = ["jenkinSG"]
    tags= {
        Name = "Jenkins-master"
        Project = "Jenkins-on-AWS"
    }
  
}
#----------------------------------------
#EC2 instance for Build server
#----------------------------------------
resource "aws_instance" "Build-server" {
    ami                       = data.aws_ami.AWSLinux.id
    instance_type             = var.instance
    availability_zone         = var.ZONE
    key_name                  = "terraKey"  # key to ssh to server
    vpc_security_group_ids    = ["BuildServerSG"]
    tags = {
        Name = "Build-server"
        Project = "Jenkins-on-AWS"
    }
  
}