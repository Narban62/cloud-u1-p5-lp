#Terraforn no solo sirve para aprovsioner recurso de los vendors de nube
#configuracion del provedor
provider "aws" {
  region = var.region #region donde se desplegaran los recursos
}


# 2. Security Group para las INSTANCIAS EC2
resource "aws_security_group" "mi-sg-instancias-14" {
  name        = "mi-sg-instancias-terraform"
  description = "Security group para instancias EC2 con acceso a EFS"
  vpc_id      = "vpc-00344cfd6c2e4f068"

}

# 3. Security Group exclusivo para el EFS
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-sg-efs-terraform"
  description = "Permite trafico NFS desde las instancias EC2"
  vpc_id      = "vpc-00344cfd6c2e4f068"

}

#Reglas SG Instancias
#Entrada SSH
resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-instancias-14.id
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}
 #Salida a EFS 2049
 resource "aws_vpc_security_group_egress_rule" "egress_instancias_efs" {
  security_group_id = aws_security_group.mi-sg-instancias-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  #Destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
 }
 #Salida a All trafic
resource "aws_vpc_security_group_egress_rule" "egress_internet" {
  security_group_id = aws_security_group.mi-sg-instancias-14.id
  ip_protocol = "-1"
  #Destino
  cidr_ipv4 = "0.0.0.0/0"
}

 #Reglas SG EFS
#Entrada a EFS 2049
 resource "aws_vpc_security_group_ingress_rule" "ingress_efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  #Origen
  referenced_security_group_id = aws_security_group.mi-sg-instancias-14.id
 }
#No se requiere reglas de salida


# # 5. Instancias EC2 con montaje automatico de EFS al iniciar
# resource "aws_instance" "mi_instancia_efs" {
#   count                  = var.cantidad_instancias
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   security_groups        = [aws_security_group.mi-sg-efs.name]
#   vpc_security_group_ids = [aws_security_group.mi-sg-instancias.id]
#   tags = {
#     Name = "Mi instancia EFS - ${count.index + 1}"
#   }
# }
