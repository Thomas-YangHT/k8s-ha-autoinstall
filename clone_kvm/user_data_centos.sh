source ../CONFIG
ips=(`echo $master,$node|sed 's/,/ /g'`)
#names=(`echo $KVM_NAME|sed 's/,/ /g'`)

j=0
for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
#
cat <<EOF >user_data.$i
#cloud-config  

hostname: $i

centos:    
  units:  
    - name: ifcfg-eth0  
      content: |  
        TYPE=Ethernet
        BOOTPROTO=static
        DEFROUTE=yes
        IPV4_FAILURE_FATAL=no
        IPV6INIT=yes
        IPV6_AUTOCONF=yes
        IPV6_DEFROUTE=yes
        IPV6_FAILURE_FATAL=no
        NAME=eth0
        DEVICE=eth0
        ONBOOT=yes
        UUID=
        HWADDR=
        DNS1=$DNS1
        DNS2=$DNS2
        IPADDR=${ips[$j]}
        PREFIX=24
        GATEWAY=$GATEWAY
        PROXY_METHOD=none
        BROWSER_ONLY=no

update:
  reboot-strategy: off

users:    
  - name: root  
    ssh-authorized-keys:   
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTVrS0pCy91x47yaOFBzBYl7eBcaCRssEVifShwdFmklkHUSCHJu9MDp6lhju3mO/5toRb5lCdEU2q5HnUN27Ohqt6Mf1ICrOMd0Add9G+pmJ/9Rtb0BnGZ5SK6QaJbGU3jxoPDpik+8zfVXDCK/YWjsulheLMXJI9wR+f9/y7SEZMfH3LkDVnKhurv/gNhcea7zJrAaoH5TQLBJeNxnPxPAinWt3jMLPoPU6boHwGdhyv3tO60rFJFloJ3fVYUSzypYpHUkB+7gFs3MGv6qz9V5eK+yotSph4pUOD5XjQ172MeXZc0qm3okqZj00YvkEd5nfhS7NBo5pMRh0WnvDx root@bsd
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
