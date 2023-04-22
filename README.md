## Overview
Build VPC and EC2 environments using Terraform.

## How to setup
1. Obtain AWS access_key and secret_key

2. Set AWS Certification Information
```
aws configure --profile <profile_name>
```

3. Create Terraform secret variable file
```
cp .tfvars.example .tfvars
```

4. Set secret variable in .tfvars
```
access_key = {{your_access_key}}
secret_key = {{your_secret_key}}
my_ip = {{your_ip}}
```

5. Set up the profile in the AWS CLI
```
aws configure --profile <profile_name>
```

6. Set the AWS profile to an environment variable
```
export AWS_PROFILE=<profile_name>
```

## UseCase
- init workspace
```
terraform init
```

- format tf file
```
terraform fmt
```

- validate tf file
```
terraform validate
```

- check what will be created
```
terraform plan
```

- create resource
```
terraform apply
```

- check created resource
```
terraform show
```

- check what will be deleted
```
terraform plan -destory
```

- destroy resource
```
terraform destroy
```
