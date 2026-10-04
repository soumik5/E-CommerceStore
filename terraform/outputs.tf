output "ec2_public_ip" {
  description = "Public IP of the ecommerce EC2 instance"
  value       = aws_instance.ecommerce.public_ip
}

output "frontend_url" {
  description = "Frontend application URL"
  value       = "http://${aws_instance.ecommerce.public_ip}:3000"
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.ecommerce.public_dns
}