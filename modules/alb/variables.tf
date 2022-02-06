variable "vpc_id" {}

variable "vpc" {}


variable "ami"{
 type = string
  default = "ami-0d527b8c289b4af7f"
}

variable "instance_type"{
 type = string
  default = "t2.micro"
}

variable "keyname"{
  default = "central-region-key-pair"
}

variable "alb_sg_id" {}

variable "webserver_sg_id" {}

variable "private_subnet_id1" {}

variable "private_subnet_id2" {}

variable "public_subnet_id1" {}

variable "public_subnet_id2" {}
