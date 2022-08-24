variable "db_instance_db_name" {
  description = "The name of the postgres database to create on the DB instance"
  type        = string
  default     = "sourcesdomainprod"
}
variable "aws_region" {
  default = "us-east-2"
  type        = string
  description = "AWS region"
}


variable rds_instance_class{
    type    = string
    default = "db.m6g.large"
    description = "The instance type of the RDS instance."
}
variable "rds_engine_type" {
  description = "The database engine to use."
  type        = string
  default = "postgres"
}
variable "rds_engine_version" {
  description = "The engine version to use."
  type        = string
  default = "14.2"
}

variable family{
  description = "RDS parameter group object to apply. When defined, must conform to format outlined [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group#argument-reference). Set `description` to \"RDS default parameter group\" if upgrading from RDS module 5.x.x."
  type        = string
  default = "postgres14"
}


variable "allocated_storage" {
  description = "Allocate storage"
  type        = number
  default     = 500
}

variable rds_multi_az{
    default = true
    type = bool
    description = "Specifies whether the RDS instance is multi-AZ."
}
variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t4g.large"
}

variable "rds_subnet_ids" {
  description = "VPC subnet IDs in subnet group"
  type        = list(string)
  default     = ["subnet-0ddd752cd9d0a9ac4", "subnet-065550fef5852a705", "subnet-0bae27380e5d20104"]
}

variable "param_log_min_duration_statement" {
  description = "(ms) Sets the minimum execution time above which statements will be logged."
  type        = string
  default     = "-1"
}

variable "param_log_statement" {
  description = "Sets the type of statements logged. Valid values are none, ddl, mod, all"
  type        = string
  default     = "all"
}

variable restrict_password_commands{
    default = "1"
    description = "To use restricted password management"
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
}

variable "additional_tags" {
  type        = map(string)
  description = "[DEPRECATED: Use `tags` instead] Additional tags to set on the RDS instance."
  default     = {}
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}


variable "security_group_name" {
  description = "Name for the security group for the rds instance"
  type        = string
  default     = "sourcesdomainprodsg"
}

variable "vpc_id" {
  description = "VPC ID for the rds security group"
  type        = string
  default     = "vpc-020732e1a993f657b"
}

variable "private_network_cidr" {
  default = ["10.0.0.0/8"]
}

variable "additional_cidrs" {
  description = "Additional CIDR to connect to RDS Postgres instance"
  type        = list(string)
  default     = []
}

variable "engine_version" {
  description = "Version of RDS Postgres"
  type        = string
  default     = "12"
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "postgres12"
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}

variable "enabled_cloudwatch_logs_exports" {
  default     = true
  type        = bool
  description = "Indicates that postgresql logs will be configured to be sent automatically to Cloudwatch"
}
variable rds_instance_name{
    description = "Postgres Instance name"
    type = string
    default = ""
}

variable tag_description{
    default = "RDS instance for sd exhibit store"
    type = string
    description = "A tag to describe what the resource is/does, such as the applications it runs." 
}

variable "global_bootstrap_bucket" {
  description = "The S3 bucket created from the bootstrap module.  Only required if the rds_lambda_enabled flag is set to `true`."
  type        = string
  default     = "sd-exhibit-store-s3"
}