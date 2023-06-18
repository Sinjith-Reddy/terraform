resource "aws_instance" "Jenkins-master" {
    ami = var.AMI[ubuntu]
    instance_type = "t2.micro"
    availability_zone = var.ZONE
    key_name = "terraKey"
    vpc_security_group_ids = [jenkinSG.id]
    tags = {
        Name = "Jenkins-master"
        Project = "Jenkins-on-AWS"
    }
  
}

resource "aws_instance" "Build-server" {
    ami = var.AMI[AWSLinux]
    instance_type = "t2.micro"
    availability_zone = var.ZONE
    key_name = "terraKey"
    vpc_security_group_ids = [BuildServerSG.id]
    tags = {
        Name = "Build-server"
        Project = "Jenkins-on-AWS"
    }
  
}