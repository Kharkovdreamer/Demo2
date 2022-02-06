output "public_subnet_id1" {
  value = "${aws_subnet.pub_sub1.id}"
}

output "private_subnet_id1" {
  value = "${aws_subnet.prv_sub1.id}"
}

output "public_subnet_id2" {
  value = "${aws_subnet.pub_sub2.id}"
}

output "private_subnet_id2" {
  value = "${aws_subnet.prv_sub2.id}"
}
