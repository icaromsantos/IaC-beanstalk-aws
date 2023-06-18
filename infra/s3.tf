resource "aws_s3_bucket" "beanstalk_deploy" {
  bucket = "${var.nome}-deploys-iquinho"
}
resource "aws_s3_bucket_object" "docker" {
  depends_on = [aws_s3_bucket.beanstalk_deploy]
  bucket     = "${var.nome}-deploys-iquinho"
  key        = "${var.nome}.zip"
  source     = "${var.nome}.zip"
  #hash para ver se o arquivo mudou
  etag = filemd5("${var.nome}.zip")
}
