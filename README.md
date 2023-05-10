## Overview

Build VPC and EC2 environments using Terraform.

## How to setup

1. Create Terraform secret variable file

```
cp .tfvars.example .tfvars
```

2. Set secret variable in .tfvars

```
allow_ip_list=[]
environment=
app_name=
```

3. Obtain AWS access_key and secret_key

4. Set up the profile in the AWS CLI

```
aws configure --profile EC2VPC
```

5. Set the AWS profile to an environment variable

```
export AWS_PROFILE=EC2VPC
```

## UseCase

### init workspace

```
terraform init
```

### format tf file

```
terraform fmt
```

### validate tf file

```
terraform validate
```

### check what will be created

```
AWS_PROFILE=EC2VPC terraform plan -var-file=.tfvars
```

### create resource

```
AWS_PROFILE=EC2VPC terraform apply -var-file=.tfvars
```

### check created resource

```
terraform show
```

### check what will be deleted

```
AWS_PROFILE=EC2VPC terraform plan -destroy -var-file=.tfvars
```

### destroy resource

```
AWS_PROFILE=EC2VPC terraform destroy -var-file=.tfvars
```
