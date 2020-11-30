terraform {
  backend "s3" {
    bucket = "tom-terraform"
    key    = "clock-in"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

