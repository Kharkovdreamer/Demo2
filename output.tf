output "availability_zone1" {
  value = "${var.availability_zone1}"
}

output "availability_zone2" {
  value = "${var.availability_zone2}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
