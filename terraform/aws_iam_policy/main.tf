terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

// following is my try out
resource "aws_iam_policy" "tf_try_out" {
  name        = "tf_test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [{
      Effect : "Allow",
      Action : ["s3:Get*", "s3:List*"],
      Resource : "*"
      },
      {
        Sid : "RedshiftPolicyForLF",
        Effect : "Allow",
        Action : [
          "glue:*",
          "lakeformation:GetDataAccess"
        ],
        Resource : "*"
    }]
  })
}
