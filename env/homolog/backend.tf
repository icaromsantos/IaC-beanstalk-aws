terraform {
  backend "s3" {
    bucket = "meu-terraform-state"
    key    = "homolog/terraform.tfstate"
    region = "us-west-2"
  }
}
