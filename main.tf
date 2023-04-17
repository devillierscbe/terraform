provider "aws" {
        region = "ap-south-1"
}

module "myvpc" {
  source = "/root/modules/vpc"
}

module "my_ec2" {
  source            = "/root/modules/ec2"
  public_subnet_id  = module.myvpc.public_subnet_id
  public_sg_id      = module.myvpc.public_sg_id
}
