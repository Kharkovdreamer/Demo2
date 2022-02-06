output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "environment" {
  value = var.environment
}

output "vpc" {
  value = "${aws_vpc.main}"
}