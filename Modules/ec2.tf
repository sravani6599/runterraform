provider "aws"{

    region = "${var.region}"

    #access_key = "************"

    #sevret_key = "************"

    }

resource "aws_instance" "devserver" {

    availability_zone = "${var.availability_zones}"

    ami ="${var.ami}"

    instance_type = "${var.instance_type}"

    key_name = "instancekey"

    #user_data = file("D:/terraform/Modules/cmds.sh")

    #count = var.instance_count

    tags = {

        Name = "devserver"

        #Name = "Terraform-${count.index + 1}"

        }

    security_groups= ["${aws_security_group.ALLTRAFFIC.name}"]  


}

   //Role
resource "aws_iam_role" "web_iam_role" {
    name = "web_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

//Instance Profile
resource "aws_iam_instance_profile" "web_instance_profile" {
    name = "web_instance_profile"
    role = "web_iam_role"
} 

//Role policy
resource "aws_iam_role_policy" "web_iam_role_policy" {
  name = "web_iam_role_policy"
  role = "${aws_iam_role.web_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::gk-bucket-1"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::gk-bucket-1/*"]
    }
  ]
}
EOF
}


resource "aws_security_group" "ALLTRAFFIC" {

   name = "ALLOW TRAFFIC"

ingress {

         from_port = 22

         to_port = 22

         protocol = "TCP"

         cidr_blocks = ["0.0.0.0/0"]

    }
 ingress {

         from_port = 8080

         to_port = 8080

         protocol = "TCP"

         cidr_blocks = ["0.0.0.0/0"]

    }



    egress {

        from_port = 443

      to_port = 443

      protocol = "0"

      cidr_blocks = ["0.0.0.0/0"]



 }

 }



# resource "aws_ebs_volume" "volume1" {

#     availability_zone = "us-west-2a"

#     size = 1

#     encrypted = true

 

# }

# resource "aws_volume_attachment" "ebsattchment" {

#     device_name = "/dev/sdh"

#     volume_id = "${aws_ebs_volume.volume1.id}"

#     instance_id = "${aws_instance.ec2_pro.id}"

 

# }
