# RELIANOID Community Edition – AWS Terraform Deployment

This Terraform configuration deploys the **RELIANOID Community Edition** virtual machine from the AWS Marketplace using the official Marketplace AMI ID. It automatically provisions:

- VPC and Public Subnet  
- Internet Gateway and Route Table  
- Security Group with port rules (SSH 22, Web GUI 444)  
- Elastic IP for public access  
- An EC2 Instance based on the published RELIANOID image  
- SSH Key access for secure login (imported from your local public key)  

---

## rerequisites

- **Terraform CLI** installed (**v1.4+ recommended**)  
- **AWS account** with permission to create EC2, networking, and IAM resources  
- **Valid SSH key pair** (`id_rsa`, `id_rsa.pub`) — generate using:  
  ```bash
  ssh-keygen -t rsa -b 4096 -f id_rsa
  ```
- Subscribed to the RELIANOID Community Edition AWS Marketplace listing (must be done before deployment)

---

## Files Overview

| File              | Description |
|-------------------|-------------|
| main.tf           | Core infrastructure resources |
| variables.tf      | Input variable definitions |
| terraform.tfvars  | User-defined values (edit with your own settings) |
| outputs.tf        | Displays useful AWS resource details after deployment |
| README.md         | This documentation |

---

##  Marketplace Image Info

Replace the placeholder with the actual AMI ID for your AWS region:

```hcl
ami_id = "ami-xxxxxxxxxxxxxxxxx"
```
⚠ **Note**: AMI IDs are region-specific — you must find the correct one for your chosen AWS region.

---

##  SSH Key Setup

Generate an SSH key pair (skip if you already have one):

```bash
ssh-keygen -t rsa -b 4096 -f id_rsa
```
Copy the generated **id_rsa.pub** into this project folder.

Keep the private key (**id_rsa**) safe — you’ll need it for SSH access.

Terraform will automatically import `id_rsa.pub` into AWS as a key pair.

---

##  Deployment

Initialize and apply Terraform:

```bash
terraform init
terraform plan
terraform apply
```

---

## 🔌 Access the VM

Once deployed, you can SSH into the VM:

```bash
ssh -i id_rsa ec2-user@<elastic-ip>
```

---

##  Terraform Outputs

When you run `terraform apply`, Terraform will display outputs defined in **outputs.tf**.

### Available Outputs

| Output Name        | Description |
|--------------------|-------------|
| instance_id        | The AWS EC2 instance ID |
| instance_public_ip | Public IP address of the instance |
| instance_private_ip| Private IP within the VPC |
| availability_zone  | AWS Availability Zone where the instance is deployed |
| ami_id             | AMI used to launch the instance |
| ssh_command        | Ready-to-use SSH connection command |

### How to View Outputs

To view all outputs:

```bash
terraform output
```

To view a specific output (example: public IP only):

```bash
terraform output instance_public_ip
```

### Example Output

```plaintext
instance_id = "i-0123456789abcdef0"
instance_public_ip = "54.210.123.45"
instance_private_ip = "172.31.16.20"
availability_zone = "us-east-1a"
ami_id = "ami-0abcdef1234567890"
ssh_command = "ssh -i id_rsa admin@54.210.123.45"
```

Connect via SSH:

```bash
ssh -i id_rsa admin@54.210.123.45
```

💡 The username may vary depending on the RELIANOID AMI configuration.

---

## 🌐 Web GUI Access

Once deployed, the RELIANOID web interface will be available at:

```
https://<elastic-ip>:444
```

---

## 🗑 Destroy Resources

To delete all created resources:

```bash
terraform destroy
```

⚠ **Important**:  
- Make sure you have the correct `ami_id` in **terraform.tfvars**  
- Ensure you are subscribed to the AWS Marketplace listing before deploying
