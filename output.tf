
#   output "aws_vpc_vpc_cross_id" {
#  value = "${aws_vpc.vpc.id}"
#}




# output "subnets_cross_id" {
#  value       = "${aws_subnet.public[*].id}"
 # description = "id de vpc cross"
  
#} 



 output "vpc_cross_id" {
  value       = "${aws_vpc.vpc.id}"
  description = "id de vpc cross"
  
} 


/*  output aws_db_subnet_group_public {
 value = "${aws_db_subnet_group.public.id}"

}  */