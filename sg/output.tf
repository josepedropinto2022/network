
 output "aws_security_group__public" {
  value       = "${aws_security_group.test_sg1.id}"
  description = "aws_security_group__public_id"
  
} 
