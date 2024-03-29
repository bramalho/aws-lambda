# AWS Lamda
> An example on how to build an AWS Lamda in Python using Terraform

## Requirements
- AWS account
- AWS CLI
- Python 3
- Terraform

## AWS Account
- Create a free account at https://aws.amazon.com
- Login in https://console.aws.amazon.com and select your desired region (eu-west-1 - EU Ireland)
- Get your Access Key in Account Menu -> "My Security Credentials" -> "Identity and Access Management (IAM)" -> "Access keys" and save it somewhere secure :)

## Python
- Install python in your machine (https://www.python.org/downloads)

## Terraform
- Install terraform in your machine (https://www.terraform.io/downloads.html)

## Lambda
1. In AWS console, go to "Services" -> "Lambda" and "Create function"
2. Give the function name
3. Runtime choose "Python 3.6"
4. In Permissions chose the basic lambda permissions role
5. And then Create function

***Basic function***
```python
import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({"message": "It works!"})
    }
```

## AWS Credentials
- Install AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html)
- Configure AWS CLI

```
aws configure
```

```
AWS Access Key ID [None]: <YOUR KEY ID>
AWS Secret Access Key [None]: <YOUR ACCESS KEY>
Default region name [None]: eu-west-1
Default output format [None]: json
```

## Terraform Configuration
- In your working directory, init terraform
```bash
terraform init
```
- Create the configuration file `config.tf`
```terraform
provider "aws" {
  version = "~> 2.24"
  region  = "eu-west-1"
}
```

## Apply your first lambda
- Create a zip file with your lambda (ie: `functions/it_works.zip`)
- Write your lambda definition (ie: `terraform/lambda.tf`)
- Plan it!
```bash
terraform plan
```
If everything is ok, you'll all the resources that are going to be create/updated/deleted.
- Apply it!
```bash
terraform apply
```
Go to teh AWS Console and you'll see your lamda that is created.

[More about terraform lambda function](https://www.terraform.io/docs/providers/aws/r/lambda_function.html)
[More about terraform api gateway](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html)

## Destroy
```bash
terraform destroy
```
