variable "wait_for_certificate_issued" {
  type        = bool
  default     = false
  description = "Whether to wait for the certificate to be issued by ACM (the certificate status changed from `Pending Validation` to `Issued`)"
}

variable "domain_name_override" {
  type        = string
  description = "A domain name for which the certificate should be issued.  If this is not specified, domain name is taken from the Context."
  default     = null
  validation {
    condition     = !can(regex("[A-Z]", var.domain_name_override))
    error_message = "Domain name must be lower-case."
  }
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "Method to use for validation, DNS or EMAIL"
}

variable "process_domain_validation_options" {
  type        = bool
  default     = true
  description = "Flag to enable/disable processing of the record to add to the DNS zone to complete certificate validation"
}

variable "ttl" {
  type        = string
  default     = "300"
  description = "The TTL of the record to add to the DNS zone to complete certificate validation"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of domains that should be SANs in the issued certificate"

  validation {
    condition     = length([for name in var.subject_alternative_names : name if can(regex("[A-Z]", name))]) == 0
    error_message = "All SANs must be lower-case."
  }
}

variable "zone_name" {
  type        = string
  default     = ""
  description = "The name of the desired Route53 Hosted Zone"
}

variable "zone_id" {
  type        = string
  default     = null
  description = "The zone id of the Route53 Hosted Zone which can be used instead of `var.zone_name`."
}

variable "certificate_transparency_logging_preference" {
  type        = bool
  default     = true
  description = "Specifies whether certificate details should be added to a certificate transparency log"
}

variable "certificate_authority_arn" {
  type        = string
  default     = null
  description = "ARN of an ACM PCA"
}
