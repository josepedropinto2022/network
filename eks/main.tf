###

resource "aws_subnet" "aws_subnet_public" {
  source = "./eks/eks/roles/"
  }