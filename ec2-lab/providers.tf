# in the providers.tf file, we define the providers that we will use in the terraform configuration
# defines settings needed to connect (region, credentials, etc.)
# we can define multiple providers in the same file to connect to multiple cloud providers
provider "aws" {
  region = "us-east-1"
}

# in the aws provider block we need to add the access key and secret key
# but it is not recommended to add them here because it is not secure
# so we can use the cli to set the access key and secret key
# or add them to the environment variables like mentioned in the documentations