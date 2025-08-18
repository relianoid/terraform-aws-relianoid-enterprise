# RELIANOID Enterprise Edition - AWS Terraform Module

This guide explains how to deploy the RELIANOID Enterprise Edition
virtual machine on AWS using the official Terraform module from the
Terraform Registry.

The module provisions automatically:

-   VPC with Internet Gateway
-   Public Subnet
-   Security Group (allowing SSH 22, Web GUI 444)
-   EC2 Instance using the RELIANOID Community Edition AMI
-   Key Pair for SSH access

## Prerequisites

### Install Terraform

Download Terraform and install it for your OS.

``` bash
terraform -version
```

### Install AWS CLI

Download AWS CLI and configure it with your credentials.

``` bash
aws configure
```

### SSH Key Pair

You'll need an SSH key to access the VM. If you don't already have one:

> **Note:** Users must generate an SSH key pair in the current folder
> before running Terraform:

``` bash
ssh-keygen -t rsa -b 4096 -f id_rsa
```

This creates `id_rsa` (private key) and `id_rsa.pub` (public key). Keep
the keys in the same directory where Terraform files are stored.

------------------------------------------------------------------------

## Step 1: Find the Terraform Module

-   Go to [Terraform Registry](https://registry.terraform.io/).
-   Search for `relianoid-Enterprise`.
-   Select the official module `relianoid/relianoid-Enterprise`.

## Step 2: Create a Project Folder

``` bash
mkdir relianoid-aws
cd relianoid-aws
```

## Step 3: Create `main.tf`

``` hcl
module "relianoid-enterprise" {
  source  = "relianoid/relianoid-enterprise/aws"
  version = "1.0.1"

  ami_id              = "ami-ami-0169776ce0edf5fc5"  # default US East Marketplace AMI
  public_ssh_key_path  = "${path.module}/id_rsa.pub"
}
```

## `outputs.tf`
``` hcl
output "instance_id" {
  description = "The AWS EC2 instance ID"
  value       = module.relianoid_aws.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = module.relianoid_aws.instance_public_ip
}

output "instance_private_ip" {
  description = "Private IP within the VPC"
  value       = module.relianoid_aws.instance_private_ip
}
```

### Notes:

-   Users must generate an SSH key pair in the current folder before
    running Terraform:

``` bash
ssh-keygen -t rsa -b 4096 -f ./id_rsa -N ""
```

-   The module internally provisions all required AWS resources,
    including VPC, Subnet, Security Group, EC2 instance, and key pair.
-   Users can override `ami_id` if they wish to use a different AMI.

------------------------------------------------------------------------

## Step 4: Initialize & Deploy

Run the following:

``` bash
terraform init
terraform plan
terraform apply
```

Confirm with `yes` when prompted.

------------------------------------------------------------------------

## Step 5: Access the RELIANOID VM

After deployment, Terraform outputs the public IP address. Connect using
SSH:

``` bash
ssh -i id_rsa admin@(instance_public_ip)
```

Then open the Web GUI in your browser:

    https://<public-ip>:444

------------------------------------------------------------------------

### Available Outputs

| Output Name        | Description |
|--------------------|-------------|
| instance_id        | The AWS EC2 instance ID |
| instance_public_ip | Public IP address of the instance |
| instance_private_ip| Private IP within the VPC |
------------------------------------------------------------------------

## Destroy Resources

To delete everything created:

``` bash
terraform destroy
```

------------------------------------------------------------------------

## ⚠️ Important Notes:

-   The AMI ID used is for **us-east-1**. If you deploy in another
    region, replace it with the correct Marketplace AMI.
-   Always secure your private key (`id_rsa`).
