variable "vpc_id" {
  type        = string
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
  default     = "vpc-0e74f589d55d5d77f"
}
variable "public_subnet_ids" {
  type = list(string)
  default = [ "subnet-04eded289e0d057cb","subnet-0f12ed5c842b451f6","subnet-04d81dcf68384bae3" ]
  
}
variable "private_subnet_ids" {
  type = list(string)
  default = [ "subnet-0474d7494d733125d","subnet-04026484997ba4fef","subnet-0a789dbc8f823ba67" ]
  
}
variable "aws_region" {
  default = "us-east-2"
  type        = string
  description = "AWS region"
}
variable "replica_count" {
  type        = number
  description = "Number of Replica nodes"
  default     = 3
}
# Variable relating to ec2 instance
variable "ec2_instance_type" {
  default = "m5.2xlarge"
}
variable "environment_tag" {
  type        = string
  description = "Environment tag"
  default     = "dev"
}
variable "ec2_ami_id" {
  #default = "ami-0d16d5631792c743e" 
  default = "ami-039adf627d08db4e7"
  description = "TIO centos base image"
}


variable "key_name" {
  type = string
  default = ""
}

variable "availability_zone" {
  type        = string
  description = "Availability zone"
  default     = "us-east-2a"
}


data "aws_availability_zones" "all" {}
variable "ssh_user" {
  default = "centos"
}

variable "ssh_key_private" {
  default  = "mongoldb-keypair-prod.pem"
}
variable "mongodb_version" {
  type = string
  default = "5.0.6"
}
variable "replicaset_name" {
  default = "sd-rpl"
}