
variable "descsg" {
  type = string
  default = ""
  
}


variable "vpc_id" {
  type = string
  default = ""
  
}


variable "cdir_vpc" {
  type = string
  default = ""
  
}



variable "region" {
  type = string
  default = ""
  
}


variable "nameSG" {
  type = string
  default = ""
  
}

variable "pub_subnet" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "PubSub1" = {
      cidr_block        = "172.16.1.0/24"
      availability_zone = "eu-west-3a"
    }
    "PubSub2" = {
      cidr_block        = "172.16.3.0/24"
      availability_zone = "eu-west-3b"
    }
  }
}


variable "aws_db_subnet_group_public1" {
  type = string
  default = "wwrwt2.micro"
}


variable ingress_list {
  type = map (object({
    
    fromport = string
    protocolo= string
    cdir = string

  }))
  default = {
    "one" = {
      
      fromport = "22"
      protocolo= "tcp"
      cdir= "0.0.0.0/0"
    }
      "two" = {
      
      fromport = "3389"
      protocolo= "tcp"
      cdir= "10.0.0.0/16"
    }
    "one" = {
      
      fromport = "80"
      protocolo= "tcp"
      cdir= "0.0.0.0/0"
    }
  }

}

variable "AZregiaoDC" {
  type = string
  default = "wwrwt2.micro"
}

variable "regiaoDC" {
  type = string
  default = "wwwt2micro"
}



variable "subnet_cdir_subpublica_nat_azb" {
  type = string
  default = "scib-cross-vpc"
}

variable "subnet_cdir_subnetpriv_aza" {
  type = string
  default = "10.0.11.0/24"
}






variable "awsiamrolepolicyvpcfloewlogs" {
  type = string
  default = ""
  description = "iam role policy name to be used to cloud watch group name in flow logs"
}


variable "awsiamroleawscloudwatchloggroupnome" {
  type = string
  default = ""
  description = "iam role policy name to be used to cloud watch group name in flow logs"
}


variable "awscloudwatchloggroupnome" {
  type = string
  default = ""
  description = "iam role to be used by cloud watch log group name to vpc flow logs"
}



variable "aws_cloudwatch_log_group_nome" {
  type = string
  default = ""
  description = "cloud watch log group to get flow logs"
}


variable "environment" {
  type = string
  default = "scib-cross-IGW"
}



variable "igw_name" {
  type = string
  default = "scib-cross-IGW"
}


variable "map_public_ip_on_launch_priv" {
  type = string
  default = "scib-cross-IGW"
}


variable "map_public_ip_on_launch_pub" {
  type = string
  default = "scib-cross-IGW"
}


variable "subnet_nome_subnetpublic_aza" {
  type = string
  default = "subnetpublicaAVAZA"
}

variable "subnet_nome_subnetpriv_aza" {
  type = string
  default = "subnetpublicaAVAZB"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_par_name" {
  type = string
  default = "cocusjp"
}

 



variable "subnet_cdir_subpublica_nat_aza" {
  type = string
  default = "10.0.31.0/24"
}

variable "nome_vpc" {
  type = string
  default = "scib-cross-vpc"
}


variable "sg_ec2" {
  type = string
  default = "sssddd"
}

variable "user_data" {
  type = string
  default = "sssddd"
}


variable "aws_subnet_private1_aza_id" {
  type = string
  default = "ec2-access-to-services-role"
}

variable "ec2_name" {
  type = string
  default = "ec2nome"
}


variable "map_public_ip_on_launch_var" {
  type = string
  default = "ec2nome"
}

variable "aws_vpc_vpc_cross_id" {
  type = string
  default = "L3333LL"
}

variable "vpc_ldap_id_p" {
  type = string
  default = ""
}


variable "nome_SG_ec2" {
  type = string
  default = "L00mmmmm00LL"
}

variable "ami_id" {
  type = string
  default = "ami-0d3c032f5934e1b41"
}

variable "subnet_id" {
  type = string
  default = ""
}

 variable "security_groups" {
  type = string
  default = "SSS"
} 

variable "key_name" {
  type = string
  default = "cocusjp"
}