source ./CONFIG

sed -i -e "s!8.8.8.8!${CP1_IP}!g" -e "s!10.244.0.0/16!${CIDR_SUBNET}!g" calico/calico.yaml
