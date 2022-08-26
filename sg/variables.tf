
variable SG_data {
  type = map(object({
    to_port = number
    from_port = number
    protocol = string 
    cidr_block = list(string)
  } 
  ))
  default = {
    "80" = {
      to_port = 80
      from_port = 81
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
    "81" = {
      to_port = 80
      from_port = 81
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
  }
}




variable "vpc_id" {
  type = string
  
}



variable "description" {
  type = string
  
}







variable "nameSG" {
  type = string
  default = ""
  
}



variable SG_data1 {
  type = map(object({
     to_port = number
    from_port = number
    protocol = string 
    cidr_block = list(string)
  } 
  ))
  default = {
    "22" = {
      to_port = 22
      from_port = 22
      protocol = "ee"
      cidr_block = ["10.0.0.0/8"]
    }
    
  }
}

variable "descsg" {
  type    = string
  default = ""

}

variable SG_data2 {
  type = map(object({
     to_port = number
    from_port = number
    protocol = string 
    cidr_block = list(string)
  } 
  ))
  default = {
    "22" = {
      to_port = 22
      from_port = 22
      protocol = "ee"
      cidr_block = ["10.0.0.0/8"]
    }
    
  }
}


variable SG_data3 {
  type = map(object({
     to_port = number
    from_port = number
    protocol = string 
    cidr_block = list(string)
  } 
  ))
  default = {
    "22" = {
      to_port = 22
      from_port = 22
      protocol = "ppp"
      cidr_block = ["10.0.0.0/8"]
    }
    
  }
}