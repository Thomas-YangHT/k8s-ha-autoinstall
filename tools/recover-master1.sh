sudo systemctl stop kubelet docker
sudo rm /var/lib/etcd
sudo rm /var/lib/etcd -rf
sudo cp -r ./etcdbak /var/lib/etcd
sudo systemctl start kubelet docker

