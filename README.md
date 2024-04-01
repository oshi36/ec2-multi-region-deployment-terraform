# Deploy multi-region EC2 instances with Terraform

## Follow the below steps to deploy
- Install Terraform and aws cli.
- Create AWS account and connect to your aws account via terminal
  ```
  aws configure
  ```
- Clone the git repository
  ```
  git clone https://github.com/oshi36/ec2-multi-region-deployment-terraform.git
  ```
- This repository has modules which will deploy EC2 instances in two different regions
- Run `terraform init ` command to download aws provider modules
- Run ` terraform plan` command
- Run `terraform apply` command to create the EC2 and necessary resources
- Check in your AWS console  
