output "gitlab_runner_ips" {
  description = "Runner servers IPs"
  value       = [for instance in aws_instance.gitlab_spawner: instance.private_ip]
}
