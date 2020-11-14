// Creates runner spawners EC2 instances

resource "aws_instance" "gitlab_spawner" {
  for_each = toset(var.gitlab_private_subnets)

  ami           = var.gitlab_runner_ami
  instance_type = var.gitlab_runner_flavor
  key_name      = var.gitlab_keypair

  subnet_id              = each.key
  vpc_security_group_ids = var.gitlab_runner_sg_ids

  iam_instance_profile = var.gitlab_iam_profile_name

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Application = "gitlab"
    Role        = "gitaly"
    Name        = "gitlab-runner-${index(var.gitlab_private_subnets, each.key)}"
  }
}
