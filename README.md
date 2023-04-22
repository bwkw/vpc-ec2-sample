## Overview
Build VPC and EC2 environments using Terraform.

## How to setup
1. Create Terraform secret variable file
```
cp .tfvars.example .tfvars
```

2. Set secret variable in .tfvars
```
my_ip = {{your_ip}}
```

3. Obtain AWS access_key and secret_key

4. Set up the profile in the AWS CLI
```
aws configure --profile <profile_name>
```

5. Set the AWS profile to an environment variable
```
export AWS_PROFILE=<profile_name>
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
terraform plan
```

### create resource
```
terraform apply
```

### check created resource
```
terraform show
```

### check what will be deleted
```
terraform plan -destory
```

### destroy resource
```
terraform destroy
```
