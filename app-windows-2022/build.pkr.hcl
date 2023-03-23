build {
  sources = [
		"azure-arm.sydney"
  ]
  provisioner "powershell" {
    script = "${path.cwd}/powershell/${var.role}/install.ps1"
  }
}