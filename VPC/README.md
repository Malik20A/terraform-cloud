# terraform-project
Team 1.

This Repo is used to create an infrastructure on AWS in US regions. 

Prerequisites:
Download terraform 0.11.14 
Link of terraform 0.11.14 - https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip

provider.aws: version = "~> 2.54"

Run the following commands:
1) source setenv.sh configurations/"region"/vpc.tfvars 
This command will set your environment to focus on the region you provided and initialize a backend "s3"

2) terraform apply -var-file configuarations/"region"/vpc.tfvars 
This command will create 17 resources all needed for an infrastructure such as vpc, with public and private subnets, nat gateway, internet gateway with security groups and DynamoDB.

After the resourcea are created you should see the following output. 

![Image description](https://files.slack.com/files-pri/T3KACT7EH-F010S3MBC2Y/screen_shot_2020-03-25_at_4.10.58_pm.png)
