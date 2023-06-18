
module "producao" {
  source = "../../infra"

  nome      = "producao"
  descricao = "aplicacao-de-producao"
  max       = 5
  # tipos de máquinas https://aws.amazon.com/pt/ec2/instance-types/
  maquina  = "t2.micro"
  ambiente = "ambiente-de-producao"
}
