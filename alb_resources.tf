resource "aws_lb" "test-lb" {
  name               = "test-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_a.id,aws_subnet.subnet_b.id]

  enable_deletion_protection = false
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
 
resource "aws_lb_target_group" "target-group" {
  name     = "jenkins-task2-target"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.pvt1.id
  port             = 8080
  depends_on = [ aws_instance.pvt1 ]
}

resource "aws_lb_listener" "https-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = "443"
  protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-1:194722397683:certificate/cab6410f-c2f0-46e7-b8ad-57c824379079"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}







