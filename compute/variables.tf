# --- comput/variables.tf ---

variable "web_sg" {}
variable "public_subnet" {}



variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  default = "2"
}

variable "instance_tags" {
  type = list
  default = ["Terraform-1", "Terraform-2"]
}
