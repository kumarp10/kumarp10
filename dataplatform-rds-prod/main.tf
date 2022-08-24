module "rds_postgres" {
  source = "git@github.com:elsevier-centraltechnology/core-terraform-rds.git?ref=10.0.0"

  rds_instance_name = var.db_instance_db_name
  rds_database_name = var.db_instance_db_name

  rds_instance_class      = var.rds_instance_class
  rds_allocated_storage   = var.allocated_storage
  rds_engine_type         = var.rds_engine_type
  rds_engine_version      = var.rds_engine_version
  sm_creds_name           = "prod/rds/dataplatform-sd-exhibit-store"
  rds_private_subnets     = ["subnet-0a789dbc8f823ba67","subnet-04026484997ba4fef","subnet-0474d7494d733125d"]
  security_group_override = []
  rds_performance_insights_enabled = true
  rds_parameters_group = {
    family      = var.family
    description = "Managed by Terraform"
    parameters  = [
     
      {
        name         = "shared_preload_libraries"
        value        = "pgaudit"
        apply_method = "pending-reboot"
      },
      {
        name         = "pgaudit.log"
        value        = "all"
        apply_method = "pending-reboot"
      },
      {
        name         = "rds.log_retention_period"
        value        = "10080"
        apply_method = "pending-reboot"
      },
      {
        name  = "log_statement"
        value = var.param_log_statement
        apply_method = "pending-reboot"
      },
      {
        name  = "log_min_duration_statement"
        value = var.param_log_min_duration_statement
        apply_method = "pending-reboot"
      },
      {
        name  = "rds.restrict_password_commands"
        value = var.restrict_password_commands
        apply_method = "pending-reboot"
      }
      
    ]
  }

  rds_lambda_enabled               = true
  global_bootstrap_bucket          = var.global_bootstrap_bucket
  rds_gdpr_logging_log_name_prefix = "error/postgresql.log"

  tag_environment   = "prod"
  tag_product       = "dataplatform"
  tag_sub_product   = ""
  tag_contact       = "SourcesDomainProduction@ReedElsevier.com"
  tag_cost_code     = "RC22751"
  tag_orchestration = "manual"
  rds_multi_az = var.rds_multi_az
  tag_description = var.tag_description

}