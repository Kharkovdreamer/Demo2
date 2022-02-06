variable "vpc_id" {}

variable "sg_name"{
 type = string
 default = "alb_sg"
}

variable "sg_description"{
 type = string
 default = "SG for ALB"
}

variable "sg_tagname"{
 type = string
 default = "SG for ALB"
}

variable "sg_ws_name"{
 type = string
 default = "webserver_sg"
}

variable "sg_ws_description"{
 type = string
 default = "SG for web server"
}

variable "sg_ws_tagname"{
 type = string
 default = "SG for web"
}