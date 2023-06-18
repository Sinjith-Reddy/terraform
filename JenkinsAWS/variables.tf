variable "REGION" {
    default = "us-east-1"
}

variable "ZONE" {
    default = "us-east-1a"
}

variable "AMI" {
    type = map
    default = {
        "ubuntu" = "ami-053b0d53c279acc90"
        "AWSLinux" = "ami-022e1a32d3f742bd8"
    } 

}
