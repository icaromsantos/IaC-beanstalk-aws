
module "homologacao" {
  source = "../../infra"

  nome      = "homologacao"
  descricao = "aplicacao-de-homologacao"
  max       = 3
  # tipos de máquinas https://aws.amazon.com/pt/ec2/instance-types/
  maquina  = "t2.micro"
  ambiente = "ambiente-de-homologacao"
}
