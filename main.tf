#Terraforn no solo sirve para aprovsioner recurso de los vendors de nube
#configuracion del provedor
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos

}

resource "aws_security_group" "mi-sg"{
  name = "mi-security-group-terraform"
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
resource "aws_instance" "mi_instancia" {

  ami = "ami-0c230065b91270bc6" #id de la imagen de amazon linux 2
  instance_type = "t2.micro" #tipo de instancia
  key_name = "mi-segunda-llaves" #nombre de par de claves para acceder
  tags = {
    Name = "MiInstanciaTerraform2" #etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg.id] #asignamos el security group a la instancia


}