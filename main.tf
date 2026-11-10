#Terraforn no solo sirve para aprovsioner recurso de los vendors de nube
#configuracion del provedor
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos

}

resource "aws_security_group" "mi-sg"{
  name = "mi-security-group-terraform-windows"
  description = "security group para windows mi instancia de terraform"
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

  ami = "ami-0b5f645abc199e666" #id de la imagen de windows server 2025
  instance_type = "t3.medium" #tipo de instancia
  key_name = "mi-segunda-llaves" #nombre de par de claves para acceder
  tags = {
    Name = "MiInstanciaTerraformWindows" #etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg.id] #asignamos el security group a la instancia


}