resource "aws_route" "private_route_fw" {
  count                  = length(local.private_route_table_id)
  route_table_id         = local.private_route_table_id[count.index]
  destination_cidr_block = local.vpn_cidr[0]
  network_interface_id   = aws_network_interface.private.id
  depends_on             = [aws_instance.pfsense]
}