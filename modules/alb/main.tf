
#Create Launch config
resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix      = "webserver-launch-config"
  image_id         =  var.ami
  instance_type    =  var.instance_type
  key_name         =  var.keyname
  security_groups  = ["${var.webserver_sg_id}"]
  
#   root_block_device {
#             volume_type = "gp2"
#             volume_size = 10
#             encrypted   = true
#         }
    # ebs_block_device {
    #         device_name = "/dev/sdf"
    #         volume_type = "gp2"
    #         volume_size = 5
    #         encrypted   = true
    #     }
    lifecycle {
        create_before_destroy = true
     }
    user_data = filebase64("${path.module}/init.sh")

}

#Auto Scaling Group
resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name       = "Demo-ASG-tf"
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  force_delete         = true
  depends_on           = [aws_lb.ALB-tf]
  target_group_arns    =  ["${aws_lb_target_group.TG-tf.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = ["${var.private_subnet_id1}","${var.private_subnet_id2}"]
  
 tag {
       key                 = "Name"
       value               = "Demo-ASG-tf"
       propagate_at_launch = true
    }
}

#Target group
resource "aws_lb_target_group" "TG-tf" {
  name       = "Demo-TargetGroup-tf"
  depends_on = [var.vpc]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }
}

#load balancer
resource "aws_lb" "ALB-tf" {
   name              = "Demo-ALG-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb_sg_id}"]
  subnets            = ["${var.public_subnet_id1}","${var.public_subnet_id2}"]       
  tags = {
        name  = "Demo-AppLoadBalancer-tf"
        Project = "demo2-tf"
       }
}
#load balancer  Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}

output "lb_dns_name" {
  value = aws_lb.ALB-tf.dns_name
}