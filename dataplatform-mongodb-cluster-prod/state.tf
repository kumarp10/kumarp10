terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "elsevier-dataplatform-mongo-023759106857"
    key     = "prod/terraform/mongo/sd-entity-store/terraform.tfstate"
    encrypt = "true"
    profile = "dataplatform-prod"
    versioning {
      enabled = true
    }
  }
}

