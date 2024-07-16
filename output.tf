output "ip-address" {
  value       = "${aws_instance.osrm.public_ip}"
}

output "ssh" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.osrm.public_ip}"
}

output "logs" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.osrm.public_ip} 'sudo docker ps --filter \"ancestor=osrm/osrm-backend\" --format \"{{.ID}}\" | xargs -I {} sudo docker logs {}'"
}