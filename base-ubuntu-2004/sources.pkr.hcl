locals {
	timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "this" {
  region = lookup(var.region, "aws", "us-west-2")

  source_ami_filter {
    filters = {
       virtualization-type = "hvm"
       name = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
       root-device-type = "ebs"
    }
    owners = ["099720109477"] # Canonical
    most_recent = true
  }

  instance_type = "t3.medium"
  ssh_username = "ubuntu"
  ami_name = "${var.application}-${local.timestamp}"

  tags = {
    owner = var.owner
    application = var.application
    Base_AMI_Name = "{{ .SourceAMIName }}"
  }
}

source "vsphere-clone" "this" {
	template = "ubuntu-20-cloudinit"
	cluster = "Cluster"
	datastore = "vsanDatastore"

	vm_name = "${var.application}-ubuntu-20"
	ssh_username = "root"
	ssh_password = var.ssh_password
}