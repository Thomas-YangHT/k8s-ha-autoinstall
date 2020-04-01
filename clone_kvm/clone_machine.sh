source ../CONFIG
#KVMDIR=/mnt/kvm
[ "$OS_TYPE" = "coreos" ] && sh user_data.sh
[ "$OS_TYPE" = "centos" ] && sh user_data_centos.sh

RUN_nodes=`virsh list|awk 'NR>2{print $2}'`

#clone & copy-in-conf & start 
for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
  flag=0  
  for j in $RUN_nodes
  do 
     if [ "$PREFIX-$i" = "$j" ]
     then 
        flag=1
     fi
     echo i: $i j: $j flag: $flag
  done
  echo $flag
  if [ "$flag" = "0" ]
  then 
    virt-clone -o $BASE_IMAGE_NAME -n ${PREFIX}-$i -f $KVMDIR/${PREFIX}-$i.img && \
    cp user_data.$i user_data && \
    virt-copy-in -d ${PREFIX}-$i user_data /var/lib/coreos-install/ && \
    virsh start ${PREFIX}-$i
  fi  
done

#copy config in
#for i in `echo $KVM_NAME|sed 's/,/ /g'`
#do 
#  cp user_data.$i user_data && \
#  virt-copy-in -d ${PREFIX}-$i user_data /var/lib/coreos-install/ && \
#  virsh start ${PREFIX}-$i
#done
