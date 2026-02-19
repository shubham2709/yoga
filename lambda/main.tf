resource "aws_lambda_function" "bedrock_lambda" {
  function_name    = var.lambda_name
  runtime         = "python3.9"
  handler         = "lambda_function.lambda_handler"
  role            = aws_iam_role.lambda_role.arn
  filename        = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256

  environment {
    variables = {
      BEDROCK_MODEL_ID = var.bedrock_model_id
    }
  }
}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_src"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bedrock_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
