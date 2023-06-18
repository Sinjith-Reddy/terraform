#----------------------------------------
#EC2 instance for Jenkins Master
#----------------------------------------
resource "aws_instance" "Jenkins-master" {
    ami                       = var.AMI["ubuntu"]
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
    ami                       = var.AMI["AWSLinux"]
    instance_type             = var.instance
    availability_zone         = var.ZONE
    key_name                  = "terraKey"  # key to ssh to server
    vpc_security_group_ids    = ["BuildServerSG"]
    tags = {
        Name = "Build-server"
        Project = "Jenkins-on-AWS"
    }
  
}