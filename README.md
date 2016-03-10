### Getting started with Terraform

#### Notes:
- This example assumes that you will have aws credentials configured in your shell environment
- Defaults to us-east-1 region.
- You will also need to replace key_name in the commands below.

I usually configure my shell with variables like this:

```
export AWS_ACCESS_KEY=[redacted]
export AWS_ACCESS_KEY_ID=[redacted]
export AWS_SECRET_KEY=[redacted]
export AWS_SECRET_ACCESS_KEY=[redacted]
```

This Terraform example has the following structure:

- variables - Contains re-usable variables for the various resources
- network - Establishes the networking components (VPC, subnet, Internet Gateway)
- securitygroups - Creates the security groups for public-ssh access
- autoscaling - Creates launch configuration and auto scaling group for instances to run in

### Planning

```
terraform plan -var "key_name=XYZ"
```

This will output the plan for resources to be created, updated, or deleted as part of running the Terraform files.


### Creation

```
terraform apply -var "key_name=XYZ"
```

This will create all of the resources defined in Terraform and give you a small (3 node) ubuntu cluster.


### Cleanup
```
terraform destroy -var "key_name=XYZ"
```

This will delete all of the resources created by application of the Terraform plan
