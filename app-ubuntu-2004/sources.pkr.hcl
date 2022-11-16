locals {
	timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

data "hcp-packer-iteration" "this" {
  bucket_name = "base"
  channel = "ubuntu-20-04"
}

data "hcp-packer-image" "aws" {
  bucket_name = "base"
  iteration_id = data.hcp-packer-iteration.this.id
  cloud_provider = "aws"
  region = lookup(var.region, "aws", "us-west-2")
}

data "hcp-packer-image" "vsphere" {
  bucket_name = "base"
  iteration_id = data.hcp-packer-iteration.this.id
  cloud_provider = "vsphere"
  region = lookup(var.region, "vmware", "Datacenter")
}

source "amazon-ebs" "this" {
  region = lookup(var.region, "aws", "us-west-2")

  source_ami = data.hcp-packer-image.aws.id

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
	template = data.hcp-packer-image.vsphere.id
	cluster = "Cluster"
	datastore = "vsanDatastore"

	vm_name = "${var.application}-ubuntu-20.04"
	ssh_username = "root"
	ssh_password = "Hashi123!"
}