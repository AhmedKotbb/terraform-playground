# the backend in terraform is used to store the state of the terraform configuration
# it has 2 types: local and remote
# local backend is used to store the state of the terraform configuration in a local file ( terraform.tfstate )
# remote backend is used to store the state of the terraform configuration in a remote storage like S3
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# example of remote backend
# terraform {
#   backend "s3" {
#     bucket = "bucket-name"
#     key    = "envs/prod/terraform.tfstate"
#     region = "us-east-1"
#   }
# }