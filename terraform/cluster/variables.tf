# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

variable "region" {
  type        = string
  description = "AWS region for all resources."
  default = "ca-central-1"
}

variable "label" {
  type        = string
  description = "Application label."
}

variable "app" {
  type        = string
  description = "Application name."
}

variable "digi_region" {
  type        = string
  description = "Digital Ocean Location"
  default = "tor1"
}

variable "cluster_name" {
  type        = string
  description = "Digital Ocena cluster name "
  default = "example-cluster"
}
