provider "aws" {
  region = var.region  
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = var.bucket

  index_document {
    suffix = var.index_key
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket
  key    = var.index_key
  source = var.index_location 
  acl    = var.index_object_acl
}

resource "aws_s3_object" "supporting_files" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket
  key    = var.supporting_file_key
  source = var.supporting_file_location 
  acl    = var.supporting_file_object_acl
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}