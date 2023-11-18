terraform {
    backend "s3" {
        bucket = "my-tf-bucket-ghndrx"
        key    = "terraform.tfstate"
        region = "us-west-2"
    }
}

# Rest of your Terraform configuration goes here...
