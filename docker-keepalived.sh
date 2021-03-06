sudo modprobe ip_vs
source ./CONFIG
docker run --net=host \
--cap-add=NET_ADMIN \
--name keepalived \
-e VIRTUAL_IP="$VIP_IP" \
-e STATE=`[ $HOSTNAME = "master1" ] && echo MASTER || echo BACKUP` \
-e PRIORITY=`[ $HOSTNAME = "master1" ] && echo 101 || echo 100` \
-e INTERFACE=`ip link |grep ^2:|awk -F': ' '{print $2}'` \
--restart=always \
-d keepalived 
