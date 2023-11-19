# Provider configuration
provider "aws" {
    region = "us-west-2"
    # Add your AWS access and secret keys here

}

resource "aws_s3_bucket" "my-tf-bucket-ghndrx" {
  bucket = "my-tf-bucket-ghndrx"

  tags = {
    Name        = "tf-backend"
    Environment = "production"
  }
}

# Output the bucket name
output "my-tf-bucket-ghndrx" {
    value = aws_s3_bucket.my-tf-bucket-ghndrx.bucket
}




