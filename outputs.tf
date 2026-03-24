# ──────────────────────────────────────────────
# html-devops-lab · Outputs Terraform
# ──────────────────────────────────────────────

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.web.public_ip
}

output "instance_public_dns" {
  description = "DNS público da instância EC2"
  value       = aws_instance.web.public_dns
}

output "site_url" {
  description = "URL do site"
  value       = "http://${aws_instance.web.public_ip}"
}
