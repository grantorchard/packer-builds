data "hcp-packer-iteration" "base" {
  bucket_name = "base-ubuntu-1804"
  channel = "latest"
}

data "hcp-packer-image" "aws" {
  bucket_name = "base-ubuntu-1804"
  iteration_id = data.hcp-packer-iteration.base.id
  cloud_provider = "aws"
  region = "us-west-2"
}