locals {}

source "amazon-ebs" "boundary" {

  region = var.region

  source_ami = data.hcp-packer-image.aws.id

  instance_type = "t2.medium"
  ssh_username = "ubuntu"
  ami_name = "boundary-{{timestamp}}"

  tags = merge(var.tags, {
    application = "boundary-${var.boundary_version}"
  })
}
