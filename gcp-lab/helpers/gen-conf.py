#!/usr/bin/python3

import csv
import ipaddress
import os

MARK_IPSEC = "# IPSec Connections"


def get_ipsec_conn(r):
  conn = (
      f'conn {r["group_name"]}-0',
      f'  leftupdown="/var/lib/strongswan/ipsec-vti.sh 0 {str(ipaddress.IPv4Network(r["router_range_0"])[2])} {str(ipaddress.IPv4Network(r["router_range_0"])[1])}"',
      f'  right={r["vpn_if_0"]}',
      f'  rightid={r["vpn_if_0"]}',
      f'conn {r["group_name"]}-1',
      f'  leftupdown="/var/lib/strongswan/ipsec-vti.sh 1 {str(ipaddress.IPv4Network(r["router_range_1"])[2])} {str(ipaddress.IPv4Network(r["router_range_1"])[1])}"',
      f'  right={r["vpn_if_1"]}',
      f'  rightid={r["vpn_if_1"]}'
  )
  return "\n".join(conn)


ipsec_conf_content = ""
frr_conf_content = ""

try:
  csv_file = open("entries.csv", "r")
  reader = csv.DictReader(csv_file, delimiter=',')

  ipsec_template_file = open("ipsec.conf.template", "r")
  ipsec_conf_content = ipsec_template_file.read()

  frr_template_file = open("frr.conf.template", "r")
  frr_conf_content = frr_template_file.read()

except (IOError, OSError) as e:
  raise SystemExit(e)

neighbor_entries = []
route_map_entries = []

for r in reader:
  r = {k: v.strip() for k, v in r.items()}
  ipsec_conf_content = ipsec_conf_content + get_ipsec_conn(r)

  neighbor_entries.append(
      f'neighbor {str(ipaddress.IPv4Network(r["router_range_0"])[2])} remote-as {r["asn"]}')
  neighbor_entries.append(
      f'neighbor {str(ipaddress.IPv4Network(r["router_range_1"])[2])} remote-as {r["asn"]}')

  route_map_entries.append(
      f'  neighbor {str(ipaddress.IPv4Network(r["router_range_0"])[2])} route-map gcp in')
  route_map_entries.append(
      f'  neighbor {str(ipaddress.IPv4Network(r["router_range_0"])[2])} route-map gcp out')
  route_map_entries.append(
      f'  neighbor {str(ipaddress.IPv4Network(r["router_range_1"])[2])} route-map gcp in')
  route_map_entries.append(
      f'  neighbor {str(ipaddress.IPv4Network(r["router_range_1"])[2])} route-map gcp out')

frr_conf_content = frr_conf_content.replace(
    "$neighbor$", "\n".join(neighbor_entries))
frr_conf_content = frr_conf_content.replace(
    "$route-map$", "\n".join(route_map_entries))

try:
  ipsec_conf = open("/etc/ipsec.conf", "w")
  ipsec_conf.write(ipsec_conf_content)
  ipsec_conf.close()

  frr_conf = open("/etc/frr/frr.conf", "w")
  frr_conf.write(frr_conf_content)
  frr_conf.close()
except (IOError, OSError) as e:
  raise SystemExit(e)

os.system("service strongswan-starter restart")
os.system("service frr restart")
