source ./CONFIG

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
   virsh shutdown ha-$i
done
