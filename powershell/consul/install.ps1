

Invoke-WebRequest -Uri "https://releases.hashicorp.com/consul/1.15.1/consul_1.15.1_windows_386.zip" -OutFile "$env:TEMP\consul_1.15.1_windows_386.zip"
New-Item -Path "C:\Program Files\consul" -ItemType Directory
New-Item -Path "C:\Program Files\consul\data" -ItemType Directory
Expand-Archive "$env:TEMP\consul_1.15.1_windows_386.zip" -DestinationPath "c:\Program Files\consul\"

$consul_config =@"
datacenter = "dc1"
data_dir = "c:\Program Files\consul\data"
log_level = "INFO"
node_name = hostname
server = false
retry_join = [
      "provider=azure tag_key=customer tag_value=daff subscription_id=14692f20-9428-451b-8298-102ed4e39c2a"
]  
"@

Set-Content -Path "c:\Program Files\consul\config.hcl" -Value $consul_config

$consul_params = @{
    Name = "HashiCorp Consul"
    BinaryPathName = "c:\Program Files\consul\consul.exe agent -config-file=c:\Program Files\consul\config.hcl"
    DependsOn = "NetLogon"
    DisplayName = "HashiCorp Consul"
    StartupType = "Automatic"
    Description = "HashiCorp Consul Agent"
  }
New-Service @consul_params

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools