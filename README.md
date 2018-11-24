```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
# To install k8s-1.12.1 on coreos                            

# Prepare:
* download:
   * coreos-k8s.tgz        ----- k8s 1.12.1's docker image&kubelet/kubeadm/kubectl
   * ha.tgz                ----- docker image: keepalived.tar/haproxy.tar/etcd.tar
   * coreosbase2.tgz       ----- kvm's img for CoreOS 1855.4
* cp [CONFIG.single-example|CONFIG.multi-example] CONFIG
* vi CONFIG  #just need modify node&master's IP
* clone or install CoreOS machines

# Install for single master:
sh -x install.sh all

# Install for multi master:
sh -x install.sh allha

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
