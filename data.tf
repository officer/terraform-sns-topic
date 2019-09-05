# SNS AssumeRole
data "aws_iam_policy_document" "assume_role_policy_sns" {
  statement {
      actions = ["sts:AssumeRole"]
      principals {
          type = "Service"
          identifiers = ["sns.amazonaws.com"]
      }
      
  }
}

# SNS IAM Policy for delivery log
data "aws_iam_policy_document" "basic_sns_policy" {
  statement {
    actions = [
        "logs:CreateLogGroup"
      ]
      effect = "Allow"
      resources = ["*"]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    effect = "Allow"
    resources = ["*"]
  }
}


# Region, Account Id
data "aws_region" "current" {}

data "aws_caller_identity" "self" {}
