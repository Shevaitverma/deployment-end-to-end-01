output "instance_id" {
value = aws_instance.backend.id
description = "ID of the backend EC2 instance"
}


output "public_dns" {
value = aws_instance.backend.public_dns
description = "Public DNS of the backend EC2 instance"
}