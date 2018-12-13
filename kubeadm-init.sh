source ./CONFIG

sudo kubeadm init --kubernetes-version=$K8S_VER --pod-network-cidr=$CIDR_SUBNET --apiserver-advertise-address=0.0.0.0
