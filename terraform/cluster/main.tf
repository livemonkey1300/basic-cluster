terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {}

resource "digitalocean_kubernetes_cluster" "example" {
  name    = "example-cluster"
  region  = "tor1"
  version = "latest"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

output "kubeconfig" {
  value = digitalocean_kubernetes_cluster.example.kube_config.0.raw_config
  sensitive = true
}
