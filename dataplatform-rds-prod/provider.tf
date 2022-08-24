provider "aws" {
  region  = "${var.aws_region}"
  profile = "dataplatform-prod"
}