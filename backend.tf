terraform {
  backend "s3" {
    bucket = "end-task-backend-bucket"
    key    = "jenkins_task/terraform.tfstate"
    region = "us-east-1"
  }
}