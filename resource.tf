resource "aws_s3_bucket" "bucket1" {
    bucket = "web-bucket-tarakesh"
  
}

terraform {
  backend "s3" {
    bucket = "tf-state-staticwebsite"
    key    = "terraform.tfstate"
    #source = "D:\\TARAKESH\\Terraform_Practice\\static-website-hosting\\static-website-hosting-1\\Static Webiste Hosting Using Terraform\\terraform.tfstate"
    region = "ap-southeast-2"
  }
}

data "aws_region" "current" {}

resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index" {
 bucket = aws_s3_bucket.bucket1.bucket
  key    = "index.html"
  source = "D:\\TARAKESH\\Terraform_Practice\\static-website-hosting\\static-website-hosting-1\\Static Webiste Hosting Using Terraform\\index.html"  # Path to your local error.html file
  #acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.bucket1.bucket
  key    = "error.html"
  source = "D:\\TARAKESH\\Terraform_Practice\\static-website-hosting\\static-website-hosting-1\\Static Webiste Hosting Using Terraform\\error.html"  # Path to your local error.html file
  #acl    = "public-read"
  content_type = "text/html"
}


resource "aws_s3_bucket_website_configuration" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject", "S3:PutObject" ],
      "Resource": [
        "${aws_s3_bucket.bucket1.arn}",
        "${aws_s3_bucket.bucket1.arn}/*"
      ]
    }
  ]
}
EOF
}