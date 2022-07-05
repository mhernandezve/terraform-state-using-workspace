variable "region" {
  type = string
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
  description = "Bucket name"
}

variable "versioned" {
  type = string
  description = "Versioned?"
  default = "Disabled"
}

variable "acl" {
  type = string
  description = "acl"
}

variable "allow_access" {
  type = list(string)
  description = "Allow Access List"
}
