source ./CONFIG

cat << EOF > kubeadm-config.yaml.master1
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: $K8S_VER
apiServerCertSANs:
- "$LOAD_BALANCER_DNS"
- "$VIP_IP"
- "$CP1_IP"
- "$CP2_IP"
- "$CP3_IP"
- "$CP1_HOSTNAME"
- "$CP2_HOSTNAME"
- "$CP3_HOSTNAME"
api:
  controlPlaneEndpoint: "$LOAD_BALANCER_DNS:$LOAD_BALANCER_PORT"
etcd:
  local:
    extraArgs:
      listen-client-urls: "https://127.0.0.1:2379,https://$CP1_IP:2379"
      advertise-client-urls: "https://$CP1_IP:2379"
      listen-peer-urls: "https://$CP1_IP:2380"
      initial-advertise-peer-urls: "https://$CP1_IP:2380"
      initial-cluster: "$CP1_HOSTNAME=https://$CP1_IP:2380"
      name: $CP1_HOSTNAME
    serverCertSANs:
      - $CP1_HOSTNAME
      - $CP1_IP
    peerCertSANs:
      - $CP1_HOSTNAME
      - $CP1_IP
networking:
    podSubnet: "$CIDR_SUBNET"
EOF

cat << EOF > kubeadm-config.yaml.master2
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: $K8S_VER
apiServerCertSANs:
- "$LOAD_BALANCER_DNS"
- "$VIP_IP"
- "$CP1_IP"
- "$CP2_IP"
- "$CP3_IP"
- "$CP1_HOSTNAME"
- "$CP2_HOSTNAME"
- "$CP3_HOSTNAME"
api:
    controlPlaneEndpoint: "$LOAD_BALANCER_DNS:$LOAD_BALANCER_PORT"
etcd:
  local:
    extraArgs:
      listen-client-urls: "https://127.0.0.1:2379,https://$CP2_IP:2379"
      advertise-client-urls: "https://$CP2_IP:2379"
      listen-peer-urls: "https://$CP2_IP:2380"
      initial-advertise-peer-urls: "https://$CP2_IP:2380"
      initial-cluster: "$CP1_HOSTNAME=https://$CP1_IP:2380,$CP2_HOSTNAME=https://$CP2_IP:2380"
      initial-cluster-state: existing
      name: $CP2_HOSTNAME
    serverCertSANs:
      - $CP2_HOSTNAME
      - $CP2_IP
    peerCertSANs:
      - $CP2_HOSTNAME
      - $CP2_IP
networking:
    podSubnet: "$CIDR_SUBNET"
EOF

cat << EOF > kubeadm-config.yaml.master3
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: $K8S_VER
apiServerCertSANs:
- "$LOAD_BALANCER_DNS"
- "$VIP_IP"
- "$CP1_IP"
- "$CP2_IP"
- "$CP3_IP"
- "$CP1_HOSTNAME"
- "$CP2_HOSTNAME"
- "$CP3_HOSTNAME"
api:
    controlPlaneEndpoint: "$LOAD_BALANCER_DNS:$LOAD_BALANCER_PORT"
etcd:
  local:
    extraArgs:
      listen-client-urls: "https://127.0.0.1:2379,https://$CP3_IP:2379"
      advertise-client-urls: "https://$CP3_IP:2379"
      listen-peer-urls: "https://$CP3_IP:2380"
      initial-advertise-peer-urls: "https://$CP3_IP:2380"
      initial-cluster: "$CP1_HOSTNAME=https://$CP1_IP:2380,$CP2_HOSTNAME=https://$CP2_IP:2380,$CP3_HOSTNAME=https://$CP3_IP:2380"
      initial-cluster-state: existing
      name: $CP3_HOSTNAME
    serverCertSANs:
      - $CP3_HOSTNAME
      - $CP3_IP
    peerCertSANs:
      - $CP3_HOSTNAME
      - $CP3_IP
networking:
    podSubnet: "$CIDR_SUBNET"
EOF
