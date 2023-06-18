#-------------------------------------------------------------------------------
# DATA SOURCE
# get the details of the default vpc avaiable in aws account to use below while creating securty groups
# change it if you want to provisio in another VPC
#-------------------------------------------------------------------------------
data "aws_vpc" "default" {
  default = true   //filter
}

#-------------------------------------------------------------------------------
#Creating security group for Jenkins Master Server
#-------------------------------------------------------------------------------
resource "aws_security_group" "jenkinsSG" {
  name        = "jenkinSG"
  description = "Security group to alow only HTTP/HTTPS connections to Jenkins server through Nginx"
  vpc_id      = data.aws_vpc.default.id        // here default is the variable name
  //direclty provide vpc id or replace default with the vpc name it will fetch the id

  ingress {
    description      = "Allow traffic from Nginix"
    from_port        = 80  #from_port and to_port is the range of ports you want to open
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.default.cidr_block]
    //ipv6_cidr_blocks = [data.aws_vpc.default.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "jenkinsSG"
    Project = "Jenkins-on-AWS"
  }
}
#-------------------------------------------------------------------------------
#Creating security group for Build Server
#-------------------------------------------------------------------------------

resource "aws_security_group" "BuildServerSG" {
  name        = "BuildServerSG"
  description = "Security group to allow jenkins server to connect to build server for running the builds"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow traffic from jenkinsSG"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    source           = [jenkinsSG.id]
    cidr_blocks      = [data.aws_vpc.default.cidr_block]
    //ipv6_cidr_blocks = [data.aws_vpc.default.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "BuildServerSG"
    Project = "Jenkins-on-AWS"
  }
}

