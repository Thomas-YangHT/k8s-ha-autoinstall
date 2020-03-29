source ../CONFIG
ips=(`echo $master,$node|sed 's/,/ /g'`)
#names=(`echo $KVM_NAME|sed 's/,/ /g'`)

j=0
for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
#
cat <<EOF >user_data.$i
#cloud-config  
#virtio: eth0; rt8139: ens3
hostname: $i

coreos:    
  units:  
    - name: static.network  
      content: |  
        [Match]  
        Name=eth0  

        [Network] 
        Address=${ips[$j]}/24  
        Gateway=$GATEWAY  
        DNS=$DNS1
        DNS=$DNS2

update:
  reboot-strategy: off

users:    
  - name: core  
    ssh-authorized-keys:   
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcTRuH0N2CmznNpCegxF7fUBsP4XzuaPwolHJpxTWP+BRdFN93KqHRszLRpcwJ7mYMavX7suhDpmvS1uLm/f4QQeapEhcAGMglsuokTmyUG0icf/3BV6panP51zpmY8WX2/+XGFNC/RWXdmzc6RtV5pwKMj+fz96NtwmWwC4m32wfS1EX66yEXapdATZhMvde0reAECwot0gtxvpM5pvGXRaKv+Q0J62ozx7ZoFHwgARJJnVbXbypDeDvZPfFsC0mwd/HozFl9smaEsW8DSUSnA2sb+AThe5ys1G/heK8TpWJ9TWjspIpSMGFwrxmcY0dPI+J5hCecFd0duqYjTWEF yanght@yanght-IH4DG
    # ssh rsa 这里插入ssh的public key，用于安装后远程ssh连接时候使用。

  - groups:  
      - sudo  
      - docker
      - wheel
      - rkt
EOF
#
((j++))
done
