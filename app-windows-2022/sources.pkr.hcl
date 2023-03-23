locals {
	timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "azure-arm" "sydney" {
  use_azure_cli_auth = true

  managed_image_name = "windows_server_2022_iis_consul_${local.timestamp}"
  managed_image_resource_group_name = "tfo-apj-packer-images"

//   shared_image_gallery_destination {
//     subscription = var.subscription_id
//     resource_group = "tfo-apj-packer-images"
//     gallery_name = "tfo_apj_packer_images"
//     image_name = "Base Windows Server 2022"
//     image_version = "1.0.0"
//     replication_regions = ["Australia Central", "Australia Southeast"]
//     storage_account_type = "Standard_LRS"
// }

  allowed_inbound_ip_addresses = ["119.75.3.194/32"]
  os_type = "Windows"
  image_publisher = "MicrosoftWindowsServer"
  image_offer = "WindowsServer"
  image_sku = "2022-datacenter-g2"
  
  communicator = "winrm"
  winrm_use_ssl = true
  winrm_username = "packer"
  winrm_insecure = true

  location = "Australia East"
  vm_size = "Standard_D4_v4"
  // user_data_file = "./ssh.sh"
    

}