terraform {
  cloud { 
    
    organization = "acorriveau" 

    workspaces { 
      name = "learn-terraform-circleci" 
    } 
  } 

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      hashicorp-learn = "circleci"
    }
  }
}


provider "digitalocean" {}

# resource "digitalocean_kubernetes_cluster" "example" {
#   name    = var.cluster_name
#   region  = var.digi_region
#   version = "latest"

#   node_pool {
#     name       = "default"
#     size       = "s-2vcpu-2gb"
#     node_count = 1
#   }
# }


# Tutorial part

resource "random_uuid" "randomid" {}

 resource "aws_s3_bucket" "app" {
   tags = {
     Name = "App Bucket"
   }

   bucket        = "${var.app}.${var.label}.${random_uuid.randomid.result}"
   force_destroy = true
 }

 resource "aws_s3_bucket_object" "app" {
   acl          = "public-read"
   key          = "index.html"
   bucket       = aws_s3_bucket.app.id
   content      = file("./assets/index.html")
   content_type = "text/html"
 }

 resource "aws_s3_bucket_acl" "bucket" {
   bucket = aws_s3_bucket.app.id
   acl    = "public-read"
 }

 resource "aws_s3_bucket_website_configuration" "terramino" {
   bucket = aws_s3_bucket.app.bucket

   index_document {
     suffix = "index.html"
   }

   error_document {
     key = "error.html"
   }
 }



