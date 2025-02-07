# Note that, the variables with default values are optional in module
variable "lambda_func_name" {
    type = string
    description = "Name of lambda functtion"
}

variable "python_version" {
    type = string
    description = "Name of lambda functtion"
    default = "python3.8"
}

variable "lambda_role_arn" {
    type = string
    description = "ARN for role with which lambda needs to be executed."
}
