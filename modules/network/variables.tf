variable "vpc_id" {}

variable "availability_zone1"{}

variable "availability_zone2"{}


variable "pub_sub1_cidr_block"{
   type        = string
   default     = "192.168.1.0/24"
}

variable "pub_sub2_cidr_block"{
   type        = string
   default     = "192.168.2.0/24"
}
variable "prv_sub1_cidr_block"{
   type        = string
   default     = "192.168.3.0/24"
}
variable "prv_sub2_cidr_block"{
   type        = string
   default     = "192.168.4.0/24"
}

