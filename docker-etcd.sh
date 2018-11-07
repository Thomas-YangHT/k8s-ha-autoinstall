source $HOME/coreos-k8s/CONFIG
IP=`ip a show dev eth0|grep inet|grep brd|grep -Po 'inet \K\d+.\d+.\d+.\d+'`
docker run --net=host \
  -d \
  -v /var/lib/etcd:/data \
  -v $HOME/coreos-k8s/ssl:/etc/etcd/ssl \
  --name etcd-${HOSTNAME} \
  --restart=always \
  etcd:latest \
  etcd \
  --name ${HOSTNAME}.yunwei.edu \
  --advertise-client-urls https://${IP}:2379 \
  --initial-advertise-peer-urls https://${IP}:2380 \
  --listen-peer-urls  https://${IP}:2380 \
  --listen-client-urls  https://${IP}:2379,https://127.0.0.1:2379 \
  --initial-cluster "${CP1_HOSTNAME}=https://${CP1_IP}:2380,${CP2_HOSTNAME}=https://${CP2_IP}:2380,${CP3_HOSTNAME}=https://${CP3_IP}:2380" \
  --cert-file  /etc/etcd/ssl/etcd.pem \
  --key-file  /etc/etcd/ssl/etcd-key.pem \
  --peer-cert-file  /etc/etcd/ssl/etcd.pem \
  --peer-key-file  /etc/etcd/ssl/etcd-key.pem \
  --trusted-ca-file  /etc/etcd/ssl/ca.pem \
  --peer-trusted-ca-file  /etc/etcd/ssl/ca.pem \
  --initial-cluster-token  etcd-cluster-1 \
  --initial-cluster-state  new 

