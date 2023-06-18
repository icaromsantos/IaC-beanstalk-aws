terraform {
  backend "s3" {
    bucket = "meu-terraform-state"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}
