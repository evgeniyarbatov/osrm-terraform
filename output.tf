output "ssh" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.osrm.public_ip}"
}

output "logs" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.osrm.public_ip} 'tail -f /var/log/cloud-init-output.log'"
}