// data source
// get the details of the default vpc
data "aws_vpc" "default" {
  default = true   //filter
}

// Security group creation
resource "aws_security_group" "jenkinsSG" {
  name        = "jenkinSG"
  description = "jenkinSG"
  vpc_id      = data.aws_vpc.default.id        // here main is the vpc name
  //direclty provide vpc id or replace main with the vpc name it will fetch the id

  ingress {
    description      = "Allow traffic from Nginix"
    from_port        = 80
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

resource "aws_security_group" "BuildServerSG" {
  name        = "BuildServerSG"
  description = "Build Environment SG"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow traffic from jenkinsSG"
    from_port        = 22
    to_port          = 22
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
    Name = "BuildServerSG"
    Project = "Jenkins-on-AWS"
  }
}

