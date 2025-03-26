output "websiteendpoint" {
    value = "http:\\${aws_s3_bucket.bucket1.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com/"
  
}