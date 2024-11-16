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




