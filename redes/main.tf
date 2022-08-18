

########################
####################################





###$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




resource "aws_vpc" "vpc" {
  cidr_block = var.cdir_vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "VPCprimcipal"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}


##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


resource "aws_route_table" "public" {
  for_each = var.pub_subnet
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rt_tags"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = each.value.id
}


###################
###########
obter automaticamenet as az  

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



#https://stackoverflow.com/questions/59097391/terraform-how-to-supply-attributes-of-resources-which-where-created-using-one-r

/*  resource "aws_db_subnet_group" "public" {
  name       = "my_database_subnet_group"
 subnet_ids = values(aws_subnet.public)[*].id

  tags = {
    Name = "My DB subnet group"
  }
}  */




################################################################################################

##https://dev.betterdoc.org/infrastructure/2020/02/04/setting-up-a-nat-gateway-on-aws-using-terraform.html
####https://thecloudbootcamp.com/pt/blog/aws/criando-vpc-com-uma-subnet-publica-utilizando-terraform/


# Criação da Rota Default para Acesso à Internet
##resource "aws_route" "tcb_blog_routetointernet" {
##  route_table_id            = aws_route_table.nat_gateway.id
##  destination_cidr_block    = "0.0.0.0/0"
 ## gateway_id                = aws_internet_gateway.nat_gateway.id


##}



resource "aws_nat_gateway" "example" {
 
  for_each      = var.pub_subnet
  
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name        = "nat-${each.key}"
  }
}