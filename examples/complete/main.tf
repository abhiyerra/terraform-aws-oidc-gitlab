provider "aws" {
  region = var.aws_region
}

resource "aws_iam_policy" "deployer" {
  name        = "gitlab-deployer-policy"
  description = "GitLab Deployer"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}

module "aws_oidc_gitlab" {
  for_each = var.gitlab
  source = "../../"

  iam_role_name           = "gitlab_action_oidc_aws"
  attach_admin_policy     = true
  create_oidc_provider    = true
  aws_managed_policy_arns = [aws_iam_policy.deployer.arn]
  gitlab_url              = "https://gitlab.com"
  audience                = "https://gitlab.com"
  match_field             = each.value.match_field
  match_value             = each.value.match_value
}
