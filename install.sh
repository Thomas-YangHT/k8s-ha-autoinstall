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

#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

#import config
[ -n "$2" ] && ([ "$2" = "-c" ] || [ "$2" = "--config" ]) && [ -f $3 ] && echo "use config file:$3" && source ./$3 \
|| echo "use default configfile" && source ./CONFIG
#import FUNC
source ./FUNCTION
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
  echo "check etcd:"
  func_etcdcheck
;;
reboot)
  echo "reboot:"
  func_reboot
;;
getsvc)
  echo "get svc:"
  func_getsvc
;;
genindex)
  echo "gen index svc.html:"
  func_genindex
;;
getpods)
  echo "get pods:"
  func_getpods
;;
calicocheck)
  echo "check calico :"
  func_calicocheck
;;
clusterinfo)
  echo "cluster info:"
  func_clusterinfo
;;
timezone8)
  echo "timezone8:"
  func_timezone8
;;
route)
  echo "route:"
  func_route
;;
status)
  echo "cluster status:"
  func_etcdcheck
  func_calicocheck
  func_getpods
  func_clusterinfo
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
  for ((i=0;i<15;i++));
  do
      echo "wait master1's pods start...."
      func_getpods;sleep 2
      [ $PodsRun -ge 3 ] && break
  done
  func_master2
  func_network
  func_dashboard
  func_nodejoin
  func_finish
;;
help|*)
  echo "usage: $0 [prepare|p]|p1|p2|p3|p4|[1|base]|[2|addon]|[3|ha]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help|...   [-c|--config  /path/to/config/config.filename]"
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
        calicocheck    :check calico status\n\
        getpods        :get pods -o wide\n\
        getsvc         :get svc -o wide\n\
        genindex       :gen index svc.html\n\
        status         :get etcd&calico&pods\n\
        timezone8      :set timezone CST-8\n\
        route          :add route temporally\n\
  "
;;
esac

#cost seconds
D2=`date +%s`
echo ALL Mission completed in $((D2-D1)) seconds

#END.
