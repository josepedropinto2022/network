 module "network1" {
  ## ionit nao funcionasource = "git::https://github.com/josepedropinto2022/network.git//redes?ref=v1.0.0"
       # source = "git::https://github.com/josepedropinto2022/network.git//redes?ref=v1.0.2"
  source = "./network/redes"

  # source = "git::https://github.com/josepedropinto2022/network.git//redes"

  pub_subnet = var.pub_subnet
  regiaoDC   = var.region
  #AZregiaoDC = local.AZregiaoDC
  cdir_vpc = var.cdir_vpc
  ##subnet_cdir_subnetpriv_aza = var.subnet_cdir_subnetpriv_aza
  #subnet_nome_subnetpriv_aza = "awslab-subnet-private"
  subnet_cdir_subpublica_nat_aza = "172.26.0.0/27"
  subnet_cdir_subnetpriv_aza     = "172.26.0.32/27"
  subnet_cdir_subpublica_nat_azb = "172.26.0.64/27"
  nome_vpc                       = "awslab-vpc"
  #routetable_name = "awslab-rt-internet"
  igw_name = "cocus_IGW"
  ###LDAP_VPC
  map_public_ip_on_launch_priv = false
  map_public_ip_on_launch_pub  = true
  environment ="kkk"
  subnet_nome_subnetpublic_aza = "awslab-subnet-public"
  subnet_nome_subnetpriv_aza   = "awslab-subnet-private"


}

####



