variable "project_name" {
  type        = string
  description = "Project used for terraform"

  validation {
    condition     = length(var.project_name) > 0
    error_message = "Project name is required."
  }
}

variable "domain_name" {
  type        = string
  description = "Base domain name of project eg. google.com, stackoverflow.com"

  validation {
    condition     = length(var.domain_name) > 0
    error_message = "Domain name is required."
  }
}

variable "sub_domain" {
  type        = string
  description = "Sub domain that would be used to serve GUI application"

  validation {
    condition     = length(var.sub_domain) > 0
    error_message = "Sub-domain name is required."
  }
}

variable "env_name" {
  type        = string
  description = "Environment name eg. dev, uat, prd"

  validation {
    condition     = length(var.env_name) > 0
    error_message = "Environment name is required."
  }
}

variable "acm_cert_arn" {
  type        = string
  description = "ARN of ACM-based SSL certificate for this project"

  validation {
    condition     = length(var.acm_cert_arn) > 0
    error_message = "ACM certificate ARN is required."
  }
}

variable "ipv4_whitelist" {
  type        = list(string)
  description = "List of permitted IPv4 Addresses."
}
