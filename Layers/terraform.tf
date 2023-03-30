module "ec2" {

  source = "../Modules"

  region = "us-west-2"

  availability_zones = "us-west-2a"

  ami = "ami-0efa651876de2a5ce"

  instance_type = "t2.micro"

 
  }
