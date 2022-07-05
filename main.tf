provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket  = "tfstate-mhg"
    key     = "workspace/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

resource "aws_s3_bucket" "bucket_name" {
  bucket   = "${var.bucket_name}-${terraform.workspace}"
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket_name.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket_name.id
  versioning_configuration {
    status = var.versioned
  }
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.bucket_name.id 
  policy = data.aws_iam_policy_document.allow_access_document.json
}

data "aws_iam_policy_document" "allow_access_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.allow_access
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket_name.bucket}"]
 }
}
