# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#

###  CREATE ROLE FUNCTION

resource "aws_lambda_function" "create_role" {
  filename         = var.provisioning_framework_archive_path
  function_name    = "aft-account-provisioning-framework-create-aft-execution-role"
  description      = "AFT account provisioning framework - create_role"
  role             = aws_iam_role.aft_lambda_aft_account_provisioning_framework_create_role.arn
  handler          = "aft_account_provisioning_framework_create_role.lambda_handler"
  source_code_hash = var.provisioning_framework_archive_hash
  memory_size      = 1024
  runtime          = "python3.8"
  timeout          = 300
  layers           = [var.aft_common_layer_arn]

  vpc_config {
    subnet_ids         = var.aft_vpc_private_subnets
    security_group_ids = var.aft_vpc_default_sg
  }
}

resource "aws_cloudwatch_log_group" "create_role" {
  name              = "/aws/lambda/${aws_lambda_function.create_role.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}


###  TAG ACCOUNT FUNCTION

resource "aws_lambda_function" "tag_account" {
  filename         = var.provisioning_framework_archive_path
  function_name    = "aft-account-provisioning-framework-tag-account"
  description      = "AFT account provisioning framework - tag_account"
  role             = aws_iam_role.aft_lambda_aft_account_provisioning_framework_tag_account.arn
  handler          = "aft_account_provisioning_framework_tag_account.lambda_handler"
  source_code_hash = var.provisioning_framework_archive_hash
  memory_size      = 1024
  runtime          = "python3.8"
  timeout          = 300
  layers           = [var.aft_common_layer_arn]

  vpc_config {
    subnet_ids         = var.aft_vpc_private_subnets
    security_group_ids = var.aft_vpc_default_sg
  }
}

resource "aws_cloudwatch_log_group" "tag_account" {
  name              = "/aws/lambda/${aws_lambda_function.tag_account.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}

###  PERSIST METADATA FUNCTION

resource "aws_lambda_function" "persist_metadata" {
  filename         = var.provisioning_framework_archive_path
  function_name    = "aft-account-provisioning-framework-persist-metadata"
  description      = "AFT account provisioning framework - persist_metadata"
  role             = aws_iam_role.aft_lambda_aft_account_provisioning_framework_persist_metadata.arn
  handler          = "aft_account_provisioning_framework_persist_metadata.lambda_handler"
  source_code_hash = var.provisioning_framework_archive_hash
  memory_size      = 1024
  runtime          = "python3.8"
  timeout          = 300
  layers           = [var.aft_common_layer_arn]

  vpc_config {
    subnet_ids         = var.aft_vpc_private_subnets
    security_group_ids = var.aft_vpc_default_sg
  }
}

resource "aws_cloudwatch_log_group" "persist_metadata" {
  name              = "/aws/lambda/${aws_lambda_function.persist_metadata.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}

###  Account Metadata SSM Function



resource "aws_lambda_function" "account_metadata_ssm" {
  filename         = var.provisioning_framework_archive_path
  function_name    = "aft-account-provisioning-framework-account-metadata-ssm"
  description      = "AFT account provisioning framework - account_metadata_ssm"
  role             = aws_iam_role.aft_lambda_aft_account_provisioning_framework_persist_metadata.arn
  handler          = "aft_account_provisioning_framework_account_metadata_ssm.lambda_handler"
  source_code_hash = var.provisioning_framework_archive_hash
  memory_size      = 1024
  runtime          = "python3.8"
  timeout          = 300
  layers           = [var.aft_common_layer_arn]

  vpc_config {
    subnet_ids         = var.aft_vpc_private_subnets
    security_group_ids = var.aft_vpc_default_sg
  }
}

resource "aws_cloudwatch_log_group" "account_metadata_ssm" {
  name              = "/aws/lambda/${aws_lambda_function.account_metadata_ssm.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}
