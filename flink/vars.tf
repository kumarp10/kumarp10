variable "ec2_ami_id" {
  #default = "ami-0d16d5631792c743e" 
  default = "ami-075bfc6f7d62f29c9"
  description = "TIO centos base image"
}
variable "replica_count" {
  type        = number
  description = "Number of Replica nodes"
  default     = 3
}
variable "ec2_instance_type" {
  default = "m5.large"
}
variable "environment_tag" {
  type        = string
  description = "Environment tag"
  default     = "flink-dev"
}
data "aws_availability_zones" "all" {}
variable "ssh_user" {
  default = "centos"
}
variable "ssh_key_private" {
  default  = "mongo-keypair.pem"
}
variable "vpc_id" {
  type        = string
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
  default     = "vpc-020732e1a993f657b"
}
variable "private_subnet_ids" {
  type = list(string)
  default = [ "subnet-0bae27380e5d20104","subnet-0ddd752cd9d0a9ac4","subnet-065550fef5852a705" ]
  
}