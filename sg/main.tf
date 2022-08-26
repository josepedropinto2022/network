#SG para aws_ecs_cluster

 #SG ec2 windows







resource "aws_security_group" "test_sg1" {
  
  name        = var.nameSG
   description  = var.description

  dynamic ingress {
  for_each = var.SG_data
  content{
    
    from_port = ingress.value.from_port
    to_port = ingress.value.to_port
    protocol  = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
  }

  }
  vpc_id = var.vpc_id
     tags = {
    Name      = "public"
  }
}

#######k8inicio

resource "aws_security_group" "worker_group_mgmt_one" {
  
  name        = var.nameSG
  description  = var.description

  dynamic ingress {
  for_each = var.SG_data1
  content{
    
    from_port = ingress.value.from_port
    to_port = ingress.value.to_port
    protocol  = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
  }

  }
  vpc_id = var.vpc_id
     tags = {
    Name      = "public"
  }
}



resource "aws_security_group" "worker_group_mgmt_two" {
  
  name        = var.nameSG
  description  = var.description

  dynamic ingress {
  for_each = var.SG_data2
  content{
    
    from_port = ingress.value.from_port
    to_port = ingress.value.to_port
    protocol  = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
  }

  }
  vpc_id = var.vpc_id
     tags = {
    Name      = "public"
  }
}




resource "aws_security_group" "all_worker_management" {
  
  name        = var.nameSG
  description  = var.description

  dynamic ingress {
  for_each = var.SG_data3
  content{
    
    from_port = ingress.value.from_port
    to_port = ingress.value.to_port
    protocol  = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
  }

  }
  vpc_id = var.vpc_id
     tags = {
    Name      = "public"
  }
}


######K8 fim






/* resource "aws_security_group_rule" "ingress_all" {
  for_each          = var.SG_data
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.test_sg1.id
  to_port           = each.value.to_port
  type              = each.value.type
  cidr_blocks      = [each.value.cidr_block]
}


 */

/* 

resource "aws_security_group" "public" {

  
  name   = "SG_EC2_WINDOWS"
 ##nao estou a passar o id mas o cdir  vpc_id = "${var.vpc_ldap_id_p}" 
   #vpc_id = file("dadossubnet")
   vpc_id = "${var.vpc_ldap_id_p}"
   #vpc_id = aws_vpc.vpc_cross.id

   #vpc_ldap_id_p = file("dadossubnet")



dynamic "ingress" {
      iterator = port
      for_each = var.ingress_list
        content {
          from_port=port.value["fromport"]
          to_port=port.value["fromport"]
          protocol = port.value["protocolo"]    
          cidr_blocks      = toset([port.value["cdir"]]) 
        }
    }





  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   
  }
   tags = {
    nome= var.nome_SG_ec2
  }

}

 #SG ec2 windws


output "egid" {

value= aws_security_group.public.id

}  



 #SG ec2 linux

resource "aws_security_group" "private" {
  
  name   = "SG_EC2_LINUX"
 ##nao estou a passar o id mas o cdir  vpc_id = "${var.vpc_ldap_id_p}" 
   #vpc_id = file("dadossubnet")
   vpc_id = "${var.vpc_ldap_id_p}"
   #vpc_id = aws_vpc.vpc_cross.id

   #vpc_ldap_id_p = file("dadossubnet")



    ingress {
   protocol         = "tcp"
   from_port        = "3306"
   to_port          = "3306"
   cidr_blocks      = ["172.16.1.0/24"]
   
   
  } 


ingress {
   protocol         = "tcp"
   from_port        = "22"
   to_port          = "22"
   cidr_blocks      = ["172.16.1.0/24"]
   
   
  }


  egress {
   protocol         = "icmp"
  from_port        = "-1"
   to_port          = "-1"
   cidr_blocks      = ["172.16.1.0/24"]
   
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

   tags = {
    nome= var.nome_SG_ec2
    
  }
} 


 #SG ec2 linux






resource "aws_security_group" "rds" {
  name        = var.nome_SG_ec2
  description = "jpteste"

  vpc_id      = var.aws_vpc_vpc_cross_id



  ingress {
    description = "inboundrulesremoteacess"
    from_port   = "0"
    to_port     = "0"
    protocol    = "6"
    cidr_blocks = [var.cdir_vpc]
  }

  ingress {
    description = "EFS inboundrulesremoteacess"
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    nome= var.nome_SG_ec2

  }
}




resource "aws_security_group" "public" {
  name = "cloudcasts-${var.infra_env}-public-sg"
  description = "Public internet access"
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name        = "cloudcasts-${var.infra_env}-public-sg"
    Role        = "public"
    Project     = "cloudcasts.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}
 
resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.public.id
}



resource "aws_subnet" "public" {
  for_each    = var.pub_subnet
  vpc_id      = aws_vpc.vpc.id
  #cidr_block  = each.value["public_cidr"]
  cidr_block  = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  #availability_zone       = each.value.availability_zone
  tags = {
    Name      = "public-${each.key}"
  }
}
 */