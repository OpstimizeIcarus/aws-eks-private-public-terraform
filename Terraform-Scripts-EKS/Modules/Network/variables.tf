
variable "vpc_cidr" {
  type = string
}

variable "proj" {
  type = string
}

variable "az" {
  type = list(string)
}


variable "eks_subnet" {
  type = list(string)
}


variable "vpc_endpoints" {
  type = list(string)
}
