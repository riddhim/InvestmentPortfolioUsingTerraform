#creating AWS s3 bucket

resource "aws_s3_bucket" "s3bucket" {
  bucket = var.awsbucket
}

#Take ownership of bucket, so noone else can edit it

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.s3bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Make the bucket public

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.s3bucket.id
  acl    = "public-read"
}

#Defining s3 objects(both html files)

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.s3bucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.s3bucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

#Enabling the hosting

resource "aws_s3_bucket_website_configuration" "staticwebsite" {
  bucket = aws_s3_bucket.s3bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [ aws_s3_bucket_acl.example ]
}
