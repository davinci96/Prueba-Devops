module "network" {
  source = "../../modules/network"

  app_name          = var.app_name
  environment       = var.environment
  region            = var.region
  ip_address_prefix = var.ip_address_prefix
  dev_ip_address    = var.dev_ip_address
}

module "s3" {
  source   = "../../modules/s3"
  app_name = var.app_name
}

module "iam" {
  source = "../../modules/iam"

  app_name    = var.app_name
  environment = var.environment
  bucket_name = module.s3.bucket_name
}

module "ec2" {
  source = "../../modules/ec2"

  app_name                    = var.app_name
  environment                 = var.environment
  vpc_id                      = module.network.vpc_id
  security_group_id           = [module.network.security_group_id]
  subnet_id                   = module.network.public_subnet_id
  availability_zone           = "${var.region}a"
  instance_type               = var.instance_type
  ami_id                      = var.ami_id
  associate_public_ip_address = true
  root_volume_type            = "gp3"
  root_volume_size            = 10
  root_iops                   = 3000
  key_pair                    = var.key_pair
  iam_instance_profile        = module.iam.ec2_instance_profile
  script_name                 = var.script_name
  # iam_instance_profile        = null
  instance_name = var.instance_name
}
