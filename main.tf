provider "aws" {
  profile = "terraform"
  region = var.region
}


module "vpc" {
  source               = "./modules/vpc"
}


module "network" {
  source = "./modules/network"
  vpc_id = "${module.vpc.vpc_id}"
  availability_zone1 = "${var.availability_zone1}"
  availability_zone2 = "${var.availability_zone2}"
}


module "sg" {
  source = "./modules/sg"
  vpc_id = "${module.vpc.vpc_id}"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = "${module.vpc.vpc_id}"
  vpc    = "${module.vpc.vpc}"
  public_subnet_id1    = "${module.network.public_subnet_id1}"
  public_subnet_id2    = "${module.network.public_subnet_id2}"
  private_subnet_id1   = "${module.network.private_subnet_id1}"
  private_subnet_id2   = "${module.network.private_subnet_id2}"
  alb_sg_id            = "${module.sg.alb_sg_id}"
  webserver_sg_id      = "${module.sg.webserver_sg_id}"
}
