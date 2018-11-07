source ../CONFIG
sh user_data.sh

BASE_IMAGE_NAME=coreosbase2
BASE_IP=192.168.253.23

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
  virt-clone -o $BASE_IMAGE_NAME -n ha-$i -f /export/kvm/ha-$i.img
#   :
done

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
   virsh start ha-$i
   while [ 1 ] 
   do 
       ping -c 1 $BASE_IP
       [ $? = 0 ] && scp user_data.$i core@$BASE_IP:user_data && \
       ssh core@$BASE_IP sudo cp user_data /var/lib/coreos-install/ && \
       break || sleep 1
   done
   ssh core@$BASE_IP sudo reboot 
done
