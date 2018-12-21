source ../CONFIG
[ "$OS_TYPE" = "coreos" ] && sh user_data.sh
[ "$OS_TYPE" = "centos" ] && sh user_data_centos.sh

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
   while [ 1 ] 
   do 
       BASE_IP=ha-$i
       ping -c 1 $BASE_IP
       [ $? = 0 ] && scp user_data.$i $REMOTE_USER@$BASE_IP:user_data && \
       ssh $REMOTE_USER@$BASE_IP sudo cp user_data /var/lib/coreos-install/ && \
       break || sleep 1
   done
   ssh $REMOTE_USER@$BASE_IP sudo reboot 
done

