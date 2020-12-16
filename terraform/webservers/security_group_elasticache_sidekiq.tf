resource "aws_security_group" "elasticache_sidekiq" {
  name        = "webservers-elasticache-sidekiq"
  description = "Security Group for Elasticache sidekiq"
  vpc_id      = var.aws_vpc_main.id

  tags = {
    Name = "webservers-elasticache-anycable"
  }
}

resource "aws_security_group_rule" "elasticache_sidekiq_ingress" {
  security_group_id = aws_security_group.elasticache_sidekiq.id

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 6379
  to_port                  = 6379
  source_security_group_id = aws_security_group.ecs.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "elasticache_sidekiq_egress" {
  security_group_id = aws_security_group.elasticache_sidekiq.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

