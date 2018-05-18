variable "environment_name" {}

variable "instance_type" {
  default = "t2.small"
}

variable "public_subnet_id" {
  description = "Specify the id of the subnet the client should be connected to"
}

variable "private_subnet_id" {
  description = "Specify the id of the subnet the servers should be connected to"
}

variable "server_count" {
  default = 2
}

variable "ami_id" {
  default = "ami-7b79fe14"
}
