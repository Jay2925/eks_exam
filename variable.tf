variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "ssh_key_name" {
  description = "The name of the SSH key to use for node group access"
  type        = string
 default     = "exam-ssh-key" 
}

variable "cluster_name" {
  default = "exam_eks"
}
