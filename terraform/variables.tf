variable "aws_region" {
  type        = string
  description = "aws region"
}
variable "vpc_cidr" {
  type        = string
  description = "observability vpc cidr"
}
variable "public_subnet_cidr" {
  type        = list(string)
  description = "o bservability vpc public subnet cidr"
}
variable "private_subnet_cidr" {
  type        = list(string)
  description = "observability vpc private subnet cidr"
}
variable "instance_types" {
  type        = list(string)
  description = "node instance type"
}
variable "namespaces" {
  type        = list(string)
  description = "name spaces for the project"
}