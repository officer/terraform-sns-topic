locals {
  debug = "${var.debug == "true" ? true : false}"
}


# Topic
resource "aws_sns_topic" "topic" {
  name_prefix = "${var.namespace}"
  
  # delivery configuration
  ## application
  application_success_feedback_role_arn     = "${aws_iam_role.role.arn}"
  application_failure_feedback_role_arn     = "${aws_iam_role.role.arn}"
  application_success_feedback_sample_rate  = "${var.debug ? 100 : 0}"

  ## Labmda
  lambda_success_feedback_role_arn          = "${aws_iam_role.role.arn}"
  lambda_failure_feedback_role_arn          = "${aws_iam_role.role.arn}"
  lambda_success_feedback_sample_rate       = "${var.debug ? 100 : 0}"

  ## SQS
  sqs_success_feedback_role_arn             = "${aws_iam_role.role.arn}"
  sqs_failure_feedback_role_arn             = "${aws_iam_role.role.arn}"
  sqs_success_feedback_sample_rate          = "${var.debug ? 100 : 0}"

  ## HTTP
  http_success_feedback_role_arn            = "${aws_iam_role.role.arn}"
  http_failure_feedback_role_arn            = "${aws_iam_role.role.arn}"
  http_success_feedback_sample_rate         = "${var.debug ? 100 : 0}"
}

# IAM Role
resource "aws_iam_role" "role" {
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy_sns.json}"
  name_prefix        = "${var.namespace}"
}

resource "aws_iam_role_policy" "role_policy" {
  name_prefix       = "${var.namespace}"
  policy            = "${data.aws_iam_policy_document.basic_sns_policy.json}"
  role              = "${aws_iam_role.role.id}"
}


# Log Group
## Failure
resource "aws_cloudwatch_log_group" "failure" {
  name  = "sns/${data.aws_region.current}/${data.aws_caller_identity.self.account_id}/${aws_sns_topic.topic}/Failure"
  tags  = "${var.tags}"
}

## Success
resource "aws_cloudwatch_log_group" "success" {
  count = "${var.debug ? 1 : 0}"
  name  = "sns/${data.aws_region.current}/${data.aws_caller_identity.self.account_id}/${aws_sns_topic.topic}"
  tags  = "${var.tags}"
}

