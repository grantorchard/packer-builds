locals {
	timestamp = regex_replace(timestamp(), "[- TZ:]", "")
	cts_version = var.cts_version
}

source "amazon-ebs" "cts" {
  region = var.region

	source_ami = "ami-09fdf96071b2c3736"

  instance_type = "t2.medium"
  ssh_username = "ubuntu"
  ami_name = "${var.prefix}-${local.timestamp}"

  tags = {
    owner = var.owner
    application = "cts"
    Base_AMI_Name = "{{ .SourceAMIName }}"
  }
}