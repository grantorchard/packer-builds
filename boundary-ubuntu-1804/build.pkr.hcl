build {
  sources = [
    "source.amazon-ebs.boundary"
  ]

	hcp_packer_registry {
		slug = "boundary"
		description = "Boundary base image"
		labels = {
			"owner" = "Grant Orchard"
			"application" = "boundary"
			"version" = "0.6"
		}
	}

  provisioner "ansible" {
    playbook_file = "./playbooks/playbook.yaml"
		user = "ubuntu"
		extra_arguments = [
			"--extra-vars",
			"boundary_version=${var.boundary_version}"
		]
  }
}