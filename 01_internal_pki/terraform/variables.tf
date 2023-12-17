variable "yandex_token" {
  type        = string
  description = "yc iam create-token"
  sensitive   = true
}

variable "yandex_cloud_id" {
  type        = string
  description = "yc resource-manager cloud list"
}

variable "yandex_folder_id" {
  type        = string
  description = "yc resource-manager folder list"
}

variable "yandex_zone_id" {
  type        = string
  description = "yc compute zone list"
  validation {
    condition     = can(regex("^ru-central[0-9A-Za-z\\-]*", var.yandex_zone_id))
    error_message = "The yandex_zone_id value must be a valid Cloud Zone ID."
  }
}

variable "default_image" {
  description = ""
  type        = string
  default     = "fd8aqo6nefi5b2dn1b4s" # this should be changed to a more recent version
  # or not - Debian 11 seems to be broken a bit - time needed for migration
}

variable "private_key" {
  type    = string
  default = "../internal/id_rsa" # this key is managed by terraform and should not be generated a priori
}

variable "admin_username" {
  type        = string
  default     = "ne_bknn"
  description = "Name of the administrator account on machines. Currently is not safe to change."
  validation {
    condition     = can(regex("^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\\$)$", var.admin_username))
    error_message = "The admin_username value must be a valid Linux username."
  }
}