terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    region                  = "ap-southeast-1"
    dynamodb_table          = "tf-ciphernavy-locks" # Create a DynamoDB with a partition key "LockID" and replace this name
    bucket                  = "tfstate-ciphernavy" # Create a new S3 bucket and replace this name
    key                     = "servo/movie/cdn.tfstate"
    shared_credentials_file = "~/.aws/credentials" # Location of named profiles inside developer machine
    profile                 = "mine" # Provide your AWS CLI named profile
    encrypt                 = true
  }
}

provider "aws" {
  region                  = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials" # Location of named profiles inside developer machine
  profile                 = "mine" # Provide your AWS CLI named profile

  default_tags {
    tags = {
      Name = "movie_gui"
    }
  }
}

provider "aws" {
  alias                   = "global"
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials" # Location of named profiles inside developer machine
  profile                 = "mine" # Provide your AWS CLI named profile

  default_tags {
    tags = {
      Name = "movie_gui"
    }
  }
}