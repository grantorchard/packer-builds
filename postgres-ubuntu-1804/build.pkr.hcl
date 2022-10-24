packer {
  required_plugins {
    vsphere = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/vsphere"
    }
  }
}

build {
  sources = [
		#"amazon-ebs.this",
		"vsphere-clone.this"
	]

	provisioner "ansible" {
    playbook_file = "./playbook.yaml"
    user = "ubuntu"

		extra_arguments = [
			#"-vvvv",
		]
		ansible_env_vars = [
			"ANSIBLE_REMOTE_TMP=/tmp",
			"ANSIBLE_ROLES_PATH=../roles"
		]
  }

	  hcp_packer_registry {
    bucket_name = "postgresql"

    bucket_labels = {
      "application"   = "postgresql"
    }

    build_labels = {
      "ubuntu-version" = "jammy 22.04"
      "build-time" = timestamp()
    }
  }
}