variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "bedrock_model_id" {
  description = "Bedrock model ID (e.g., anthropic.claude-v2)"
  type        = string
}
