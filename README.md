#To install k8s-1.12.1 on coreos
#  _       _                          __  __                 
# | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
# | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
# | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
# |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
#                                                             
#Prepare:
cp [CONFIG.single-example|CONFIG.multi-example] CONFIG
vi CONFIG  #just need modify node&master's IP

#download:
   coreos-k8s.tgz        #k8s 1.12.1's docker image&kubelet/kubeadm/kubectl
   ha.tgz                #docker image: keepalived.tar/haproxy.tar/etcd.tar
   coreosbase2.tgz       #kvm's img for CoreOS 1855.4

#Install for single master:
sh -x install.sh all

#Install for multi master:
sh -x install.sh allha

#Reset when reinstall:
sh -x install.sh reset

#HELP
usage: install.sh [prepare|p]|p1|p2|p3|p4|[1|base]|[2|addon]|[3|ha]|dashboard|network|node|rejoin|ingress|helm|prometheus|efk|istio|finish|default|help|...
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
        getpods        :get pods -o wide

#All files in this project:
.
├── calico
│   ├── calico-etcd.yaml
│   ├── calico.yaml
│   ├── etcd-calico-deploy.yaml
│   ├── etcd.yaml
│   └── rbac.yaml
├── clone_coreos
│   ├── clone_machine.sh
│   ├── user_data.base
│   ├── user_data.master1
│   ├── user_data.master2
│   ├── user_data.master3
│   ├── user_data.node1
│   └── user_data.sh
├── CONFIG
├── CONFIG.multi-example
├── CONFIG.single-example
├── config.tgz
├── coreosbase2.tgz
├── coreos-k8s.tgz
├── docker-etcd.sh
├── docker-haproxy.sh
├── docker-keepalived.sh
├── etcdssl.sh
├── fab_inst.py
├── fab_inst.pyc
├── haproxy.cfg
├── haproxy_conf.sh
├── ha.tgz
├── hosts
├── hosts_conf.sh
├── installha.sh
├── installv2.sh
├── join.sh
├── kubeadm_config.sh
├── kubeadm-config.yaml
├── log
├── m1_ca_files
├── master-conf.tgz
├── old
│   ├── docker-etcd-test.sh
│   ├── etcdconf.sh
│   ├── etcdjoin.sh
│   ├── keepalive_conf.sh
│   ├── keep.sh
│   ├── kubeadm_config.1.sh
│   ├── kubeadm_config.sh.bak
│   ├── m1_ca_files.old
│   └── socat_test_port.sh
├── README.md
├── ssl
│   ├── ca-config.json
│   ├── ca.csr
│   ├── ca-csr.json
│   ├── ca-key.pem
│   ├── ca.pem
│   ├── etcd.csr
│   ├── etcd-csr.json
│   ├── etcd-key.pem
│   ├── etcd.pem
│   └── etcdssl.sh
└── tools
    ├── harun.sh
    ├── recover-master1.sh
    └── route.sh

5 directories, 60 files
