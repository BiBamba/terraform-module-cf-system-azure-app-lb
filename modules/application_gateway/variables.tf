variable "address_space" {
  default = "10.21.0.0/16"
}

variable "frontend_subnet_address_prefixes" {
  default = "10.21.0.0/24"
}

variable "backend_subnet_address_prefixes" {
  default = "10.21.1.0/24"
}