resource "aws_lb" "test-lb" {
  name               = "test-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_a.id,aws_subnet.subnet_b.id]

  enable_deletion_protection = true
}

resource "aws_lb_listener" "lb_listner" {
  load_balancer_arn = aws_lb.test-lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}