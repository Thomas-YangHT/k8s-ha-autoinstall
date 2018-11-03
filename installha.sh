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
	fab -H $master,$node -f fab_inst.py prepare -u core -P --colorize-errors
}

#ha prepare
func_ha_prepare(){
	fab -H $master -f fab_inst.py prepare_ha -u core -P --colorize-errors
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

#master1
func_master1(){
	fab -H $CP1_IP -f fab_inst.py master1 -u core --colorize-errors |tee log
}

#scp master1 conf
func_scp_master1_conf(){
	 scp core@$CP1_IP:coreos-k8s/master-conf.tgz .
}

#master2
func_master2(){
	fab -H $CP2_IP,$CP3_IP -f fab_inst.py master2 -u core -P --colorize-errors |tee -a log
}

#network
func_network(){
[ $net = "calico" ] && echo "install calico" && \
fab -H $master1 -f fab_inst.py calico -u core --colorize-errors 
[ $net = "flannel" ] && echo "install flannel" && \
fab -H $master1 -f fab_inst.py flannel -u core --colorize-errors 
}

#find join command
func_nodejoin(){
cat log |grep kubeadm|grep join |awk -F'out:' '{print "sudo "$2}' >join.sh
fab -H $node -f fab_inst.py node -u core -P --colorize-errors 
}

#node rejoin
func_noderejoin(){
fab -H $master -f fab_inst.py rejoin -u core --colorize-errors |tee rejoin
cat rejoin |grep kubeadm|grep join |awk -F'out:' '{print "sudo "$2}' >join.sh
fab -H $node -f fab_inst.py node -u core -P --colorize-errors 
}

#dashboard
func_dashboard(){
[ $dashboard = true ] && echo "install dashboard" && \
fab -H $master -f fab_inst.py dashboard -u core --colorize-errors|tee -a log 
}

#ingress
func_ingress(){
[ $ingress = true ] && echo "install ingress" && \
fab -H $master -f fab_inst.py ingress -u core --colorize-errors 
}

#helm
func_helm(){
[ $helm = true ] && echo "install helm" && \
fab -H $master -f fab_inst.py helm -u core --colorize-errors
}

#prometheus
func_prometheus(){
[ $prometheus = true ] && echo "install prometheus" && \
fab -H $master -f fab_inst.py prometheus -u core --colorize-errors
}

#efk
func_efk(){
[ $efk = true ] && echo "install efk" && \
fab -H $master -f fab_inst.py efk -u core --colorize-errors
}

#istio
func_istio(){
[ $istio = true ] && echo "install istio" && \
fab -H $master -f fab_inst.py istio -u core --colorize-errors
}

#test
func_test(){
	fab -H $master,$node -f fab_inst.py test -u core --colorize-errors |tee -a log
}

#finish 
func_finish(){
	fab -H $master -f fab_inst.py finish -u core --colorize-errors |tee -a log
}

#reboot
func_reboot(){
	fab -H $master,$node -f fab_inst.py reboot -u core -P --colorize-errors |tee -a log
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
  func_nodejoin
  func_dashboard
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
keepalived)
  echo "start keepalived..."
  func_keepalived
;;
haproxy)
  echo "start haproxy..."
  func_haproxy
;;
master1)
  echo "start master1..."
  func_master1
  func_scp_master1_conf
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
test)
  echo "test"
  func_test
;;
finish)
  echo "services message:"
  func_finish
;;
reboot)
  echo "services message:"
  func_reboot
;;
help|*)
  echo "usage: $0 [prepare|p]|p1|p2|p3|[1|base]|[2|addon]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help"
  echo -e "\
        prepare|p      :cp&load all tgz&images.\n\
        p1             :cp&load base tgz&image only.\n\
        p2             :cp&load addon tgz&image only.\n\
        p3             :cp&load istio tgz&image only,join node.\n\
        1|base         :install k8s base component&calico&dashboard.\n\
        2|addon        :install k8s addon component:helm,ingress,efk,prometheus.\n\
        node           :only join node.\n\
        rejoin         :need join other node after 24h.\n\
        istio          :install istio component.\n\
        default        :install all configured in CONFIG file.\n\
        finish         :when need check login token or service status.\n\
        reboot         :reboot all\n\
  "
;;
default|all)
  echo "start all install..."
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
esac

#cost seconds
D2=`date +%s`
echo ALL Mission completed in $((D2-D1)) seconds

#END.
