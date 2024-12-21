resource "aws_instance" "instance" {
  ami                         = var.ami_id
  availability_zone           = var.availability_zone
  instance_type               = var.instance_type
  ebs_optimized               = false
  disable_api_termination     = false
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_pair
  subnet_id                   = var.subnet_id
  monitoring                  = true
  source_dest_check           = true
  vpc_security_group_ids      = var.security_group_id
  iam_instance_profile        = var.iam_instance_profile

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    iops                  = var.root_iops
    delete_on_termination = true
    encrypted             = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = base64encode(templatefile("../../scripts/${var.script_name}", {}))

  tags = {
    Name        = "${var.app_name}-${var.instance_name}",
    Environment = var.environment
  }
}
