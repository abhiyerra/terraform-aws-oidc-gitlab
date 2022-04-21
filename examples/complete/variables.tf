variable "create_oidc_provider" {
  default     = true
  description = "Flag to enable/disable the creation of the GitHub OIDC provider."
  type        = bool
}

variable "attach_admin_policy" {
  default     = false
  type        = bool
  description = "Flag to enable/disable the attachment of the AdministratorAccess policy."

}

variable "iam_policy_arns" {
  default     = ["arn:aws:iam::aws:policy/s3FullAccess"]
  description = "List of AWS IAM policy ARNs to attach to the IAM role."
  type        = list(any)
}

variable "gitlab_url" {
  type        = string
  default     = "https://gitlab.com"
  description = "The address of your GitLab instance, such as https://gitlab.com or http://gitlab.example.com."

}

variable "audience" {
  type        = string
  default     = "https://gitlab.com"
  description = "The address of your GitLab instance, such as https://gitlab.com or http://gitlab.example.com."

}

variable "gitlab" {
  default = {
    "deployer" = {
      iam_role_name = "gitlab_oidc_role"
      audience      = "https://gitlab.com"
      gitlab_url    = "https://gitlab.com"
      match_field   = "sub"
      match_value = [
        "project_path:thaunghtikeoo/demo:ref_type:branch:ref:main",
        "project_path:thaunghtikeoo/oidc-demo:ref_type:branch:ref:main"
      ]
      policy_arns = [

      ]
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"

}

