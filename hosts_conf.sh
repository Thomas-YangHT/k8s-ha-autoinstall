source ./CONFIG
hosts=(`echo $KVM_NAME|sed 's/,/ /g'`)
ips=(`echo $NODES|sed 's/,/ /g'`)

for ((i=0;i<${#ips[@]};i++));
do
 list=`echo -e "$list"  && echo ${ips[i]} ${hosts[i]} ${hosts[i]}.yunwei.edu`
done

list=`echo -e "$list"|grep -v "^$"`

cat <<EOF > hosts
$VIP_IP k8sha   $LOAD_BALANCER_DNS
$list
EOF
cat /etc/hosts |grep -v ${VIP_IP:0:7} >hosts.tmp
cat /etc/hosts hosts|grep ${VIP_IP:0:7}|sort |uniq >>hosts.tmp
sudo cp hosts.tmp /etc/hosts
