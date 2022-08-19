

########################
####################################


data "aws_availability_zones" "available" {}




###$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




resource "aws_vpc" "vpc" {
  cidr_block = var.cdir_vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "VPCprimcipal"
  }
}

resource "aws_internet_gateway" "aws_internet_gateway1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}


##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


/* resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rt_tags"
  }
} */

/* resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = each.value.id
}
 */

###################
###########

resource "aws_subnet" "aws_subnet_public" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id      = aws_vpc.vpc.id
  cidr_block = "10.20.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags =  {
    Name      = "private-${var.environment}}"
  }
}


#######

/* resource "aws_subnet" "public" {
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




##################################################################################################


resource "aws_subnet" "aws_subnet_private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.20.${20+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags =  {
    Name      = "private-${var.environment}}"
  }
}

#####################################################################################################

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


###Routing

resource "aws_route_table" "public" {
   vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway1.id
  }

  tags  =  {
    Name = "rt_tags"
  }
}

/* resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = each.value.id
}

*/
resource "aws_nat_gateway" "aws_nat_gateway_1" {
 
  count = "${length(data.aws_availability_zones.available.names)}"
  
  
    subnet_id      = "${aws_subnet.aws_subnet_public[count.index].id}" 

  tags = {
    Name        = "nat-${count.index}"
  }
}

 



resource "aws_route_table" "aws_route_table_private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "private-route-table"
    Environment = "${var.environment}"
  }
}


resource "aws_route_table" "aws_route_table_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_internet_gateway1.id
}


/* resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.aws_route_table_private.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id         = aws_nat_gateway.aws_nat_gateway_1.id
}
 */


resource "aws_route" "private_nat_gateway" {
  count = "${length(data.aws_availability_zones.available.names)}"
  route_table_id         = aws_route_table.aws_route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.aws_nat_gateway_1[count.index].id
  
}



##associate route tables and subnetes

#public subnetes

resource "aws_route_table_association" "public" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = element(aws_subnet.aws_subnet_public.*.id, count.index)
  route_table_id = aws_route_table.aws_route_table_public.id
}

##private subnetes

/* resource "aws_route_table_association" "private" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = element(aws_subnet.aws_subnet_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.paws_route_table_private.id
}
 */

####
resource "aws_route_table_association" "private" {
count = "${length(data.aws_availability_zones.available.names)}"
   subnet_id      = "${aws_subnet.aws_subnet_private_subnet[count.index].id}"  
   route_table_id = aws_route_table.aws_route_table_private.id
} 
###dd





resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

    ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Environment = "${var.environment}"
  }
}


####CONFIG FLOW LOGS
##AWS documentation  https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html
##terra links  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log

resource "aws_flow_log" "example" {
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type    = "ALL"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "example" {
  name = "var.awscloudwatchloggroupnome"
}

resource "aws_iam_role" "example" {
  name = var.awsiamroleawscloudwatchloggroupnome

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = var.awsiamrolepolicyawscloudwatchloggroupnome
  role = aws_iam_role.example.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}