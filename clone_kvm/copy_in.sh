source ../CONFIG
[ "$OS_TYPE" = "coreos" ] && sh user_data.sh
[ "$OS_TYPE" = "centos" ] && sh user_data_centos.sh

PREFIX='core' #vhost prefix
#PREFIX='${PREFIX}'

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
  cp user_data.$i user_data && \
  virt-copy-in -d ${PREFIX}-$i user_data /var/lib/coreos-install/ && \
  virsh start ${PREFIX}-$i
done
