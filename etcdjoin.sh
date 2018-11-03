export PATH=$PATH:/opt/bin
source $HOME/coreos-k8s/CONFIG && \
sudo kubectl exec -n kube-system etcd-master1 -- etcdctl \
--ca-file /etc/kubernetes/pki/etcd/ca.crt \
--cert-file /etc/kubernetes/pki/etcd/peer.crt \
--key-file /etc/kubernetes/pki/etcd/peer.key \
--endpoints=https://${CP1_IP}:2379 \
member add `cat /etc/hosts|grep $(hostname)|awk '{print $3}'` \
https://`ip a show dev eth0|grep inet|grep brd|grep -Po 'inet \K\d+.\d+.\d+.\d+'`:2380
