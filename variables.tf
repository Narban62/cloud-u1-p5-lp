 #region donde se desplegaran los recursos
 variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
 }
 variable "ami_id" {
    description = "id de la ami"
    type = string
    default = "ami-0c230065b91270bc6"
 }
 variable "instance_type" {
    description = "tipo de instancia"
    type = string
    default = "t2.micro"
 }
 variable "key_name" {
    description = "nombre de par de claves para acceder"
    type = string
    default = "mi-segunda-llaves"
 }
 variable "cantidad_instancias" {
    description = "cantidad de instancias a crear"
    type = number
    default = 2
 }