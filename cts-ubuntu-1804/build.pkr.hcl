build {
  sources = [
		"amazon-ebs.cts"
  ]
	hcp_packer_registry {
		slug = "other-ubuntu-1804"
		description = "Some other Ubuntu image"
		labels = {
			"owner" = "Grant Orchard"
			"application" = "other"
			"version" = "0.3.0"
		}
	}
	provisioner "ansible" {
    playbook_file = "./playbook.yaml"
    user = "ubuntu"
    extra_arguments = [
			"--extra-vars",
			"cts_version=${var.cts_version}"
		]
  }
}