terraform {
  required_version = "=0.12.28"

  backend "s3" {
    bucket = "jz-terraform-backend"
    key    = "hzs-api/rds.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  version = "2.70"
  region  = "eu-west-1"
}
