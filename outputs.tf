output "ids_instancias" {
  description = "Ids de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].id
}

output "cantidad_instancias" {
  description = "Cantidad de instancias creadas"
  value = length(aws_instance.mi_instancia_efs[*].id)
}

output "ip_publica_instancias" {
  description = "IP publicas de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].public_ip
}
output "zonas_disponibilidad" {
  description = "Zonas de disponibilidad de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].availability_zone
}