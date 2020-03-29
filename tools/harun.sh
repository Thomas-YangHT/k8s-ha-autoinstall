source ./CONFIG

for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
   virsh start ${PREFIX}-$i
done
