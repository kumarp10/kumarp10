# Create security group for mongoDB Instance
resource "aws_security_group" "instances" {
  name   = "sd-mongodb-sg"
  vpc_id = var.vpc_id
}


resource "aws_security_group_rule" "org_rules" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id

  from_port   = "27017"
  to_port     = "27019"
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "ssh_rules" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id

  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/8"]
}
resource "aws_security_group_rule" "outgoing" {
  type              = "egress"
  security_group_id = aws_security_group.instances.id

  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
