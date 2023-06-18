
# criação de um perfil vinculado a um cargo
resource "aws_iam_instance_profile" "beanstalk_ec2_profile" {
  name = "beanstalk-ec2-profile"
  role = aws_iam_role.beanstalk_ec2.name
}


# criação de cargo dentro da AWS
resource "aws_iam_role" "beanstalk_ec2" {
  name = "beanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# criação de politícas vinculadas a um cargo
resource "aws_iam_role_policy" "beanstalk_ec2_policy" {
  name = "beanstalk-ec2-role-policy"
  role = aws_iam_role.beanstalk_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          #Colocar métricas no cloudwatch
          "cloudwatch:PutMetricData",
          # criar computadores
          "ds:CreateComputer",
          #Descreve diretório para mudar algo nos computadores
          "ds:DescribeDirectories",
          #Pegar status das instancias
          "ec2:DescribeInstanceStatus",
          # Guardar logs
          "logs:*",
          # modificar máquinas EC2
          "ssm:*",
          # conversar máquinas no EC2
          "ecsmesages:*",
          # pegar autorização
          "ecr:GetAuthorizationToken",
          # pegar camadas da imagem
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepository",
          "ecr:ListImages",
          # importar imagem
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
