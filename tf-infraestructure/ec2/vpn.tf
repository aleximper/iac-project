module "vpn_site_to_site" {
  source = "../../tf-modules/vpn"
  bgp_asn = 65000
  customer_ip_address = "200.75.51.132"
  vpc_id = local.vpc_id
}