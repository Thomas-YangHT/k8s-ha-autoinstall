source ./CONFIG
cat <<EOF > hosts
$VIP_IP k8s k8s.yunwei.edu
$CP1_IP master1 master1.yunwei.edu
$CP2_IP master2 master2.yunwei.edu
$CP3_IP master3 master3.yunwei.edu
$NODE1_IP node1 node1.yunwei.edu
EOF
