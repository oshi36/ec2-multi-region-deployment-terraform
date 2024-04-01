terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

module "us-east-1" {

	source = "./modules/vpc_module"
         providers = {
           aws = aws.us-east-1
       }

}

module "us-east-2" {

	source = "./modules/vpc_module"
         providers = {
            aws = aws.us-east-2
  }

}


 
