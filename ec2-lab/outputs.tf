output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.nginx_server.public_ip
}