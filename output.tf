output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.vm.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.vm.public_ip
}

output "instance_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.vm.private_ip
}

output "availability_zone" {
  description = "The Availability Zone where the instance is deployed"
  value       = aws_instance.vm.availability_zone
}

output "ami_id" {
  description = "The AMI used to launch the instance"
  value       = aws_instance.vm.ami
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i id_rsa admin@${aws_instance.vm.public_ip}"
}
