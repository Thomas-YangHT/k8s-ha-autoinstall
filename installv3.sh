#!/usr/bin/bash
#
#Script for install k8s1.12.1 HA on CoreOS by LinuxMan
#  _       _                          __  __                 
# | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
# | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
# | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
# |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
#                                                             
#

#base prepare
func_base_prepare(){
	fab -H $CP1_IP,$node -f fab_inst.py prepare -u core -P --colorize-errors
}

#ha prepare
func_ha_prepare(){
	fab -H $master,$node -f fab_inst.py prepare_ha -u core -P --colorize-errors
}

#addon prepare
func_addon_prepare(){
( [ $ingress = true ] || [ $helm = true ] || [ $prometheus = true ] || [ $efk = true ] ) && \
fab -H $master,$node -f fab_inst.py addon -u core -P --colorize-errors 
}

#istio prepare
func_istio_prepare(){
[ $istio = true ] && \
fab -H $master,$node -f fab_inst.py istio_prepare -u core -P --colorize-errors 
}

#keepalived
func_keepalived(){
	fab -H $master -f fab_inst.py keepalived -u core -P --colorize-errors
}

#haproxy
func_haproxy(){
	fab -H $master -f fab_inst.py haproxy -u core -P --colorize-errors
}

#etcd
func_etcd(){
	fab -H $master -f fab_inst.py etcd -u core -P --colorize-errors
}

#master
func_master(){
        fab -H $master -f fab_inst.py master -u core --colorize-errors |tee log
}

#master1
func_master1(){
	fab -H $CP1_IP -f fab_inst.py master1 -u core --colorize-errors |tee log
	scp core@$CP1_IP:coreos-k8s/master-conf.tgz . 
}

#master2
func_master2(){
	fab -H $CP2_IP,$CP3_IP -f fab_inst.py master2 -u core  --colorize-errors |tee -a log
#	fab -H $CP3_IP -f fab_inst.py master2 -u core  --colorize-errors |tee -a log
}

#network
func_network(){
[ $net = "calico" ] && echo "install calico" && \
fab -H $CP1_IP -f fab_inst.py calico -u core --colorize-errors 
[ $net = "flannel" ] && echo "install flannel" && \
fab -H $CP1_IP -f fab_inst.py flannel -u core --colorize-errors 
}

#find join command
func_nodejoin(){
cat log |grep kubeadm|grep join |tail -1 |awk -F'out:' '{print "sudo "$2}' >join.sh
fab -H $node -f fab_inst.py node -u core -P --colorize-errors 
}

#node rejoin
func_noderejoin(){
fab -H $CP1_IP -f fab_inst.py rejoin -u core --colorize-errors |tee rejoin
cat rejoin |grep kubeadm|grep join |awk -F'out:' '{print "sudo "$2}' >join.sh
fab -H $node -f fab_inst.py node -u core -P --colorize-errors 
}

#dashboard
func_dashboard(){
[ $dashboard = true ] && echo "install dashboard" && \
fab -H $CP1_IP -f fab_inst.py dashboard -u core --colorize-errors|tee -a log 
}

#ingress
func_ingress(){
[ $ingress = true ] && echo "install ingress" && \
fab -H $CP1_IP -f fab_inst.py ingress -u core --colorize-errors 
}

#helm
func_helm(){
[ $helm = true ] && echo "install helm" && \
fab -H $CP1_IP -f fab_inst.py helm -u core --colorize-errors
}

#prometheus
func_prometheus(){
[ $prometheus = true ] && echo "install prometheus" && \
fab -H $CP1_IP -f fab_inst.py prometheus -u core --colorize-errors
}

#efk
func_efk(){
[ $efk = true ] && echo "install efk" && \
fab -H $CP1_IP -f fab_inst.py efk -u core --colorize-errors
}

#istio
func_istio(){
[ $istio = true ] && echo "install istio" && \
fab -H $CP1_IP -f fab_inst.py istio -u core --colorize-errors
}

#reset
func_reset(){
	fab -H $master,$node -f fab_inst.py reset -u core -P --colorize-errors |tee -a log
}

#finish 
func_finish(){
  fab -H $CP1_IP -f fab_inst.py finish -u core --colorize-errors |tee finish 
  str=`cat finish|sed -n -e '/get svc/,/^$/ p' -e '/token:  / p'|awk -F'out:' '{print $2}'`
  echo -e "\033[45;42m $str \033[0m"
}

#etcdcheck
func_etcdcheck(){
	fab -H $CP1_IP -f fab_inst.py etcdcheck -u core --colorize-errors |tee -a log
}

#reboot
func_reboot(){
	fab -H $master,$node -f fab_inst.py reboot -u core -P --colorize-errors
}

#getpods
func_getpods(){
	fab -H $CP1_IP -f fab_inst.py getpods -u core  --colorize-errors|tee runpods
        PodsRun=`cat runpods|grep Running|wc -l`
}


#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

#import config
source ./CONFIG
#
case $1 in
1|base)
  echo "start only base install..."
#  func_base_prepare
  func_master
  func_network
  func_dashboard
  func_nodejoin
  func_finish     
;;
2|addon)
  echo "start addon install..."
#  func_addon_prepare
  func_helm
  func_ingress
  func_prometheus
  func_efk
  func_finish   
;;
3|ha)
  echo "start HA install..."
  func_master1
  PodsRun=0
  for ((i=1;i<60;i++));
  do
      echo "wait master1's pods start...."
      func_getpods
      [ $PodsRun -ge 3 ] && break
  done
  func_master2
  func_network
  func_dashboard
  func_nodejoin
  func_finish     
;;
p|prepare)
  echo "start prepare all..."
  func_base_prepare
  func_addon_prepare
  func_istio_prepare
;;
p1|baseprepare)
  echo "start prepare..."
  func_base_prepare
;;
p2|addprepare)
  echo "start addprepare..."
  func_addon_prepare
;;
p3|istioprepare)
  echo "start istio prepare..."
  func_istio_prepare
;;
p4|haprepare)
  echo "start ha prepare..."
  func_ha_prepare
;;
p5|phek)
  echo "start ha&keepalived&etcd&haproxy prepare..."
  func_ha_prepare
  func_keepalived
  func_haproxy
  func_etcd
;;
keepalived)
  echo "start keepalived..."
  func_keepalived
;;
haproxy)
  echo "start haproxy..."
  func_haproxy
;;
etcd)
  echo "start etcd..."
  func_etcd
;;
master)
  echo "start master..."
  func_master
;;
master1)
  echo "start master1..."
  func_master1
;;
master2)
  echo "start master2..."
  func_master2
;;
dashboard)
  echo "start dashboard..."
  func_dashboard
;;
network|flannel|calico)
  echo "start network"
  func_network
;;
node)
  echo "start node join..."
  func_nodejoin
;;
rejoin)
  echo "start node rejoin..."
  func_noderejoin
;;
ingress)
  echo "start ingress"
  func_ingress
;;
helm)
  echo "start helm"
  func_helm
;;
prometheus)
  echo "start prometheus"
  func_prometheus
;;
efk)
  echo "start efk"
  func_efk
;;
istio)
  echo "start istio"
  func_istio
;;
reset)
  echo "reset"
  func_reset
;;
finish)
  echo "services message:"
  func_finish
;;
etcdcheck)
  echo "services etcd:"
  func_etcdcheck
;;
reboot)
  echo "reboot:"
  func_reboot
;;
getpods)
  echo "services getpods:"
  func_getpods
;;
default|all)
  echo "start all install k8s with single master..."
  func_base_prepare
  func_addon_prepare
  func_istio_prepare
  func_master
  func_network
  func_nodejoin
  func_dashboard
  func_helm
  func_ingress
  func_prometheus
  func_efk
  func_istio
  func_finish
;;
allha)
  echo "start HA install k8s with multi master..."
  echo "start base&ha&keepalived&etcd&haproxy prepare..."
  func_base_prepare
  func_ha_prepare
  func_keepalived
  func_haproxy
  func_etcd
  echo "start HA install..."
  func_master1
  PodsRun=0
  for ((i=1;i<60;i++));
  do
      echo "wait master1's pods start...."
      func_getpods
      [ $PodsRun -ge 3 ] && break
  done
  func_master2
  func_network
  func_dashboard
  func_nodejoin
  func_finish
;;
help|*)
  echo "usage: $0 [prepare|p]|p1|p2|p3|p4|[1|base]|[2|addon]|[3|ha]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help|..."
  echo -e "\
        p|prepare      :cp&load all tgz&images.\n\
        p1             :cp&load base tgz&images.\n\
        p2             :cp&load addon tgz&images.\n\
        p3             :cp&load istio tgz&images.\n\
        p4             :cp&load HA tgz&images.\n\
        1|base         :install k8s base component&calico&dashboard.\n\
        2|addon        :install k8s addon component:helm,ingress,efk,prometheus.\n\
        3|ha           :install HA cluster of k8s.\n\
        node           :only join node.\n\
        all|default    :install all configured in CONFIG file with single master.\n\
        allha          :install all configured in CONFIG file with HA three master.\n\
        finish         :get login token&svc.\n\
        rejoin         :need join other node after 24h.\n\
        ingress        :install ingress.\n\
        helm           :install helm.\n\
        efk            :install efk.\n\
        prometheus     :install prometheus.\n\
        istio          :install istio component.\n\
        reboot         :reboot all\n\
        reset          :kubeadm reset all\n\
        etcdcheck      :check etcd cluster\n\
        getpods        :get pods -o wide\n\
  "
;;
esac

#cost seconds
D2=`date +%s`
echo ALL Mission completed in $((D2-D1)) seconds

#END.
