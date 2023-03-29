#to update yum 
sudo su
sudo yum update -y


# to install aws cli #
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version


#Install git in your EC2 instance
sudo yum install git -y
#Check git version
git version

# Install ansible
sudo amazon-linux-extras install ansible2 -y


# Install terraform
cd /etc
mkdir terraform
cd terraform
curl -O https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip 
unzip terraform_0.12.13_linux_amd64.zip -d /usr/bin/
terraform -v

#to install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install epel -y
sudo yum install jenkins java-1.8.0-openjdk-devel
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins

