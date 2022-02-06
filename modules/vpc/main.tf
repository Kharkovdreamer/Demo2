
resource "aws_vpc" "main" { 
 cidr_block = var.cidr
 tags = { 
          Project = "demo2-tf"
          Name = "Demo2"
        }
}