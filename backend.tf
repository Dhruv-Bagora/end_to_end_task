terraform {
  backend "s3" {
    bucket = "task-backend-bucket"
    key    = "jenkins_task/terraform.tfstate"
    region = "us-west-1"
  }
}