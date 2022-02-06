#Public Subnet1
resource "aws_subnet" "pub_sub1" {  
vpc_id                  = "${var.vpc_id}"  
cidr_block              = var.pub_sub1_cidr_block  
availability_zone       = "${var.availability_zone1}"
map_public_ip_on_launch = true  
tags = {    
         Project = "demo2-tf"   
         Name = "public_subnet1"
      }
} 
#Public Subnet2 
resource "aws_subnet" "pub_sub2" {  
vpc_id                  = "${var.vpc_id}"  
cidr_block              = var.pub_sub2_cidr_block  
availability_zone       = "${var.availability_zone2}"
map_public_ip_on_launch = true  
tags = {    
         Project = "demo2-tf" 
         Name = "public_subnet2"  
       }
}

#Private Subnet1
resource "aws_subnet" "prv_sub1" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = var.prv_sub1_cidr_block
  availability_zone       = "${var.availability_zone1}"
  map_public_ip_on_launch = false
tags = {
    Project = "demo2-tf"
    Name = "private_subnet1" 
 }
}
#Private Subnet2
resource "aws_subnet" "prv_sub2" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = var.prv_sub2_cidr_block
  availability_zone       = "${var.availability_zone2}"
  map_public_ip_on_launch = false
tags = {
    Project = "demo2-tf"
    Name = "private_subnet2"
  }
}

#Public Route Table
resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }
    tags = {
    Project = "demo2-tf"
    Name = "public subnet route table" 
 }
}
# add route table to public subnet1
resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub1.id
}
# add route table to public subnet2
resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub2.id
}

# Gateway 
resource "aws_internet_gateway" "igw" {  
   vpc_id = "${var.vpc_id}"   
   tags = {    
            Project = "demo2-tf"   
            Name = "internet gateway"
          }
}

#EIP for NAT GW1 
resource "aws_eip" "eip_natgw1" {  
     count = "1"
} 
#NAT gateway1
resource "aws_nat_gateway" "natgateway_1" {  
     count         = "1"  
     allocation_id = aws_eip.eip_natgw1[count.index].id  
     subnet_id     = aws_subnet.pub_sub1.id
} 
#EIP for NAT GW2 
resource "aws_eip" "eip_natgw2" { 
     count = "1"
} 

#NAT gateway2 
resource "aws_nat_gateway" "natgateway_2" {               
     count    = "1"  
     allocation_id = aws_eip.eip_natgw2[count.index].id 
     subnet_id     = aws_subnet.pub_sub2.id
}


#route table for private subnet1
resource "aws_route_table" "prv_sub1_rt" {
  count  = "1"
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_1[count.index].id
  }
  tags = {
    Project = "demo2-tf"
    Name = "private subnet1 route table" 
 }
}
#association private subnet1 & NAT GW1
resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub1_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub1.id
}
# route table for private subnet2
resource "aws_route_table" "prv_sub2_rt" {
  count  = "1"
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_2[count.index].id
  }
  tags = {
    Project = "demo2-tf"
    Name = "private subnet2 route table"
  }
}
# association betn private subnet2 & NAT GW2
resource "aws_route_table_association" "pri_sub2_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub2_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub2.id
}