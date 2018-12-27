source ./CONFIG

cat << EOF > kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: $K8S_VER
networking:
  podSubnet: $CIDR_SUBNET
apiServer:
  certSANs:
  - "$LOAD_BALANCER_DNS"
  - "$VIP_IP"
  - "$CP1_IP"
  - "$CP2_IP"
  - "$CP3_IP"
  - "$CP1_HOSTNAME"
  - "$CP2_HOSTNAME"
  - "$CP3_HOSTNAME"
  - 127.0.0.1
controlPlaneEndpoint: "$LOAD_BALANCER_DNS:$LOAD_BALANCER_PORT"
etcd:
  external:
    endpoints:
    - https://${CP1_IP}:2379
    - https://${CP2_IP}:2379
    - https://${CP3_IP}:2379
    caFile: /etc/etcd/ssl/ca.pem
    certFile: /etc/etcd/ssl/etcd.pem
    keyFile: /etc/etcd/ssl/etcd-key.pem
  #  dataDir: /var/lib/etcd
EOF
