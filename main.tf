#Terraforn no solo sirve para aprovsioner recurso de los vendors de nube
#configuracion del provedor
provider "aws" {
  region = var.region #region donde se desplegaran los recursos
}

resource "aws_security_group" "mi-sg-efs"{
  name = "mi-security-group-terraform-efs"
  description = "security group para mi instancia de terraform"
  vpc_id = "vpc-00344cfd6c2e4f068" #id del vpc dond ese crara el security group
  #regla de entrada para ssh
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #regla de salida para http
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#declaracion de los recursos a aprovisioner de aws
resource "aws_instance" "mi_instancia_efs" {

  ami = var.ami_id #id de la imagen de amazon linux 2
  instance_type = var.instance_type #tipo de instancia
  key_name = var.key_name #nombre de par de claves para acceder
  security_groups = [aws_security_group.mi-sg-efs.name]
  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}" #etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg-efs.id] #asignamos el security group a la instancia
  count = var.cantidad_instancias
  
}