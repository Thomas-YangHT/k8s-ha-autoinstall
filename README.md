<<<<<<< HEAD
<<<<<<< HEAD
=======
![](https://img.shields.io/badge/Dist-CoreOS-blue.svg)  ![](https://img.shields.io/badge/K8S-HA-brightgreen.svg)  ![](https://img.shields.io/badge/Proxy-IPVS-orange.svg)  ![](https://img.shields.io/badge/Net-Calico-yellow.svg)

# To install k8s-1.13.0 on CoreOS                            
# Prepare:
* download:
   * [coreos-k8s-v1.13.0.tgz](https://pan.baidu.com/s/1IU_7YBirkM88q2QnbyfePg) ----- k8s 1.13.0's docker image&kubelet/kubeadm/kubectl&dashboard
   * [ha.tgz](https://pan.baidu.com/s/1Cj_BAiohKnZOi2MKCEX10g)  ----- docker image: keepalived.tar/haproxy.tar/etcd.tar
   * [coreosbase2.tgz](https://pan.baidu.com/s/141I6ctxuGtFfiD8tRHfz_g) ----- kvm's img for CoreOS 1855.4
   * [1.0 istio.tgz](https://pan.baidu.com/s/1jaQbXqHP6pzeqPDGlI1t6Q)
   * [k8s-addon.tgz](https://pan.baidu.com/s/16Ag7L_mWFyMkgoMs8tXWzA)
* CONFIG
   * vi CONFIG  -----just need modify node&master's IP
```
K8S_VER=v1.13.0
CIDR_SUBNET=10.244.0.0/16
KUBECONFIG=/etc/kubernetes/admin.conf
LOAD_BALANCER_DNS=k8sha.yunwei.edu
LOAD_BALANCER_PORT=8443
CP1_HOSTNAME=master1.yunwei.edu
CP2_HOSTNAME=master2.yunwei.edu
CP3_HOSTNAME=master3.yunwei.edu
VIP_IP=192.168.253.30
CP1_IP=192.168.253.31
CP2_IP=192.168.253.32
CP3_IP=192.168.253.33
NODE1_IP=192.168.253.34
NODE1_HOSTNAME=node1.yunwei.edu
REMOTE_USER=core
#
master="$CP1_IP,$CP2_IP,$CP3_IP"
node="$NODE1_IP"  # add IP seprate by ','
NODES="$master,$node"
net="calico" #calico or flannel
dashboard=true
helm=true
ingress=true
prometheus=true
efk=true
istio=true

#just for coreos machines
KVM_NAME="master1,master2,master3,node1"
GATEWAY=192.168.253.125
DNS1=192.168.253.110
DNS2=114.114.114.114
```
* clone
   * clone or install CoreOS machines
   <img src="https://github.com/Thomas-YangHT/k8s-ha-autoinstall/raw/master/pics/k2.png" width="500">

# Install
* Install for single master:
  * sh -x install.sh all
* Install for multi master:
  * sh -x install.sh allha
[![asciicast](https://asciinema.org/a/ESPpo0D3MQWsJo0Yo2TFG2S10.svg)](https://asciinema.org/a/ESPpo0D3MQWsJo0Yo2TFG2S10)  
   <img src="https://github.com/Thomas-YangHT/k8s-ha-autoinstall/raw/master/pics/k3.png" width="800">

#  when reinstall:
sh -x install.sh reset

# HELP
```
usage: install.sh [prepare|p]|p1|p2|p3|p4|[1|base]|[2|addon]|[3|ha]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help|...   [-c|--config  /path/to/config/config.filename]
        p|prepare      :cp&load all tgz&images.
        p1             :cp&load base tgz&images.
        p2             :cp&load addon tgz&images.
        p3             :cp&load istio tgz&images.
        p4             :cp&load HA tgz&images.
        1|base         :install k8s base component&calico&dashboard.
        2|addon        :install k8s addon component:helm,ingress,efk,prometheus.
        3|ha           :install HA cluster of k8s.
        node           :only join node.
        all|default    :install all configured in CONFIG file with single master.
        allha          :install all configured in CONFIG file with HA three master.
        finish         :get login token&svc.
        rejoin         :need join other node after 24h.
        ingress        :install ingress.
        helm           :install helm.
        efk            :install efk.
        prometheus     :install prometheus.
        istio          :install istio component.
        reboot         :reboot all
        reset          :kubeadm reset all
        etcdcheck      :check etcd cluster
        calicocheck    :check calico status
        getpods        :get pods -o wide
        getsvc         :get svc -o wide
        genindex       :gen index svc.html
        status         :get etcd&calico&pods
        timezone8      :set timezone CST-8
        route          :add route temporally

```
-----
# weixin public accunt: [LinuxMan]
* [linux command HELP,try input some cmd, such as lsof]
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/linuxman.png" width="500">

```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
>>>>>>> release-1.13.0
=======
![](https://img.shields.io/badge/Dist-CoreOS-blue.svg)  ![](https://img.shields.io/badge/K8S-HA-brightgreen.svg)  ![](https://img.shields.io/badge/Proxy-IPVS-orange.svg)  ![](https://img.shields.io/badge/Net-Calico-yellow.svg)

# To install k8s-1.13.0 on CoreOS                            
# Prepare:
* download:
   * [coreos-k8s-v1.13.0.tgz](https://pan.baidu.com/s/1IU_7YBirkM88q2QnbyfePg) ----- k8s 1.13.0's docker image&kubelet/kubeadm/kubectl&dashboard
   * [ha.tgz](https://pan.baidu.com/s/1Cj_BAiohKnZOi2MKCEX10g)  ----- docker image: keepalived.tar/haproxy.tar/etcd.tar
   * [coreosbase2.tgz](https://pan.baidu.com/s/141I6ctxuGtFfiD8tRHfz_g) ----- kvm's img for CoreOS 1855.4
   * [1.0 istio.tgz](https://pan.baidu.com/s/1jaQbXqHP6pzeqPDGlI1t6Q)
   * [k8s-addon.tgz](https://pan.baidu.com/s/16Ag7L_mWFyMkgoMs8tXWzA)
* CONFIG
   * vi CONFIG  -----just need modify node&master's IP
```
K8S_VER=v1.13.0
CIDR_SUBNET=10.244.0.0/16
KUBECONFIG=/etc/kubernetes/admin.conf
LOAD_BALANCER_DNS=k8sha.yunwei.edu
LOAD_BALANCER_PORT=8443
CP1_HOSTNAME=master1.yunwei.edu
CP2_HOSTNAME=master2.yunwei.edu
CP3_HOSTNAME=master3.yunwei.edu
VIP_IP=192.168.253.30
CP1_IP=192.168.253.31
CP2_IP=192.168.253.32
CP3_IP=192.168.253.33
NODE1_IP=192.168.253.34
NODE1_HOSTNAME=node1.yunwei.edu
REMOTE_USER=core
#
master="$CP1_IP,$CP2_IP,$CP3_IP"
node="$NODE1_IP"  # add IP seprate by ','
NODES="$master,$node"
net="calico" #calico or flannel
dashboard=true
helm=true
ingress=true
prometheus=true
efk=true
istio=true

#just for coreos machines
KVM_NAME="master1,master2,master3,node1"
GATEWAY=192.168.253.125
DNS1=192.168.253.110
DNS2=114.114.114.114
```
* clone
   * clone or install CoreOS machines
   <img src="https://github.com/Thomas-YangHT/k8s-ha-autoinstall/raw/master/pics/k2.png" width="500">

# Install
* Install for single master:
  * sh -x install.sh all
* Install for multi master:
  * sh -x install.sh allha
[![asciicast](https://asciinema.org/a/ESPpo0D3MQWsJo0Yo2TFG2S10.svg)](https://asciinema.org/a/ESPpo0D3MQWsJo0Yo2TFG2S10)  
   <img src="https://github.com/Thomas-YangHT/k8s-ha-autoinstall/raw/master/pics/k3.png" width="800">

#  when reinstall:
sh -x install.sh reset

# HELP
```
usage: install.sh [prepare|p]|p1|p2|p3|p4|[1|base]|[2|addon]|[3|ha]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help|...   [-c|--config  /path/to/config/config.filename]
        p|prepare      :cp&load all tgz&images.
        p1             :cp&load base tgz&images.
        p2             :cp&load addon tgz&images.
        p3             :cp&load istio tgz&images.
        p4             :cp&load HA tgz&images.
        1|base         :install k8s base component&calico&dashboard.
        2|addon        :install k8s addon component:helm,ingress,efk,prometheus.
        3|ha           :install HA cluster of k8s.
        node           :only join node.
        all|default    :install all configured in CONFIG file with single master.
        allha          :install all configured in CONFIG file with HA three master.
        finish         :get login token&svc.
        rejoin         :need join other node after 24h.
        ingress        :install ingress.
        helm           :install helm.
        efk            :install efk.
        prometheus     :install prometheus.
        istio          :install istio component.
        reboot         :reboot all
        reset          :kubeadm reset all
        etcdcheck      :check etcd cluster
        calicocheck    :check calico status
        getpods        :get pods -o wide
        getsvc         :get svc -o wide
        genindex       :gen index svc.html
        status         :get etcd&calico&pods
        timezone8      :set timezone CST-8
        route          :add route temporally

```
-----
# weixin public accunt: [LinuxMan]
* [linux command HELP,try input some cmd, such as lsof]
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/linuxman.png" width="500">

```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
>>>>>>> c49535504f49c70f3085ed129d06d6918ac6244d
