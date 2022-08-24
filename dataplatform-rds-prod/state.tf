terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "elsevier-dataplatform-023759106857"
    key     = "prod/terraform/rds/sd-exhibit-store/terraform.tfstate"
    encrypt = "true"
    profile = "dataplatform-prod"
    versioning {
      enabled = true
    }
    tags{
        tag_product       = "dataplatform"
    }
  }
}

