
resource "random_uuid" "randomid" {}

# S3 buckets
resource "aws_s3_bucket" "public_storage" {
  bucket        = "${var.app}.${var.label}.${random_uuid.randomid.result}"
  force_destroy = true

  tags = {
    Name = " public storage"
  }
}


resource "aws_s3_bucket_public_access_block" "public_storage" {
  bucket = aws_s3_bucket.public_storage.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "public_storage" {
  bucket = aws_s3_bucket.public_storage.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.public_storage]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "public_storage" {
  bucket = aws_s3_bucket.public_storage.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

 resource "aws_s3_object" "app" {
   acl          = "public-read"
   key          = "index.html"
   bucket       = aws_s3_bucket.public_storage.id
   content      = file("./assets/index.html")
   content_type = "text/html"
 }

 resource "aws_s3_bucket_website_configuration" "terramino" {
   bucket = aws_s3_bucket.public_storage.bucket

   index_document {
     suffix = "index.html"
   }

   error_document {
     key = "error.html"
   }
 }
