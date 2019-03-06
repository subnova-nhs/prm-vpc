resource "aws_codebuild_project" "deploy" {
  name        = "prm-vpc-deploy-${var.environment}"
  description = "Deploy the VPC"

  source {
    type      = "CODEPIPELINE"
    buildspec = "./pipeline/src/vpc/action_deploy.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  service_role = "${var.iam_role}"

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/codebuild/terraform:latest"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "ENVIRONMENT"
      value = "${var.environment}"
    }

    environment_variable {
      name  = "ACCOUNT_ID"
      value = "${data.aws_caller_identity.current.account_id}"
    }
  }

  tags {
    Environment = "${var.environment}"
  }
}
