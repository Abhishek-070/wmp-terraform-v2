resource "aws_instance" "instance" {
  count         = 5
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids= ["sg-0a4cc58f87a256401"]

  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z04759742TOEKPTLQKQGL"
  name    = "${var.components[count.index]}-dev"
  type    = "A"
  ttl     = "30"
  records = [ aws_instance.instance[count.index].private_ip]
}

variable "components"{
  default = ["frontend", "postgresql", "auth-service", "portfolio-service", "analytics-service"]
}