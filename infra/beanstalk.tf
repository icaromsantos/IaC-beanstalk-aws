# o Beanstak é dividido em duas parte Aplicação e ambiente


resource "aws_elastic_beanstalk_application" "aplicacao_beanstalk" {
  name        = var.nome
  description = var.descricao
}

resource "aws_elastic_beanstalk_environment" "ambiente_aplicacao_beanstalk" {
  name        = var.ambiente
  application = aws_elastic_beanstalk_application.aplicacao_beanstalk.name
  # descrição encontrada no site https://docs.aws.amazon.com/pt_br/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = "64bit Amazon Linux 2 v3.5.8 running Docker"
  # documentacao de namespaces https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html

  # escolhendo o tipo de máquia nano, t2, t3
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.maquina
  }

  # limite de máquina para escalar
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max
  }

  # vinculando o perfil criado
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }

}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [aws_elastic_beanstalk_environment.ambiente_aplicacao_beanstalk,
    aws_elastic_beanstalk_application.aplicacao_beanstalk,
    aws_s3_bucket_object.docker
  ]
  name        = var.ambiente
  application = var.nome
  description = var.descricao
  bucket      = aws_s3_bucket.beanstalk_deploy.id
  key         = aws_s3_bucket_object.docker.id
}
