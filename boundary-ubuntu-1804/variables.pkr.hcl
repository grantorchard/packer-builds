variable "region" {
  type = string
  default = "us-west-2"
}

variable "tags" {
  type = map(string)
  default = {
      owner = "Grant Orchard"
      application = "boundary"
      Base_AMI_Name = "{{ .SourceAMIName }}"
  }
}

variable "boundary_version" {
  type = number
  default = 0.6.2
}



