resource "aws_lb_target_group" "subdomain-target-group" {
  name     = "subdomain-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "subdomain-attachment" {
  target_group_arn = aws_lb_target_group.subdomain-target-group.arn
  target_id        = aws_instance.pvt1.id
  port             = 3000
  depends_on       = [aws_instance.pvt1]
}


resource "aws_lb_listener_rule" "main-listener-rule" {
  listener_arn = aws_lb_listener.https-listener.arn
  priority     = 1

  condition {
    host_header {
      values = ["jenkins.thedhruv.online"]  
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}


resource "aws_lb_listener_rule" "subdomain-listener-rule" {
  listener_arn = aws_lb_listener.https-listener.arn
  priority     = 2

  condition {
    host_header {
      values = ["app.thedhruv.online"]  
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.subdomain-target-group.arn
  }
}

