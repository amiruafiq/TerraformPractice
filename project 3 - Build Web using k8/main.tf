provider "aws" {
    region = "ap-southeast-1"
    access_key = "xxx"
    secret_key = "xxx"  
}

# 1. Create S3 bucket
resource "aws_s3_bucket" "ab" {
  bucket = "bucket-to-test-static-website"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Project     = "static web"
  }
}

# 2. upload index.html file to bucket


# 3. make bucket public
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.ab.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# 4. Enable s3 static website hosting
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.ab.id

  index_document {
    suffix = "index.html"
  }
}