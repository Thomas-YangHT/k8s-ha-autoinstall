source ./CONFIG

cat <<EOF > keepalived.conf.master1
global_defs {
   router_id LVS_k8s
}

vrrp_script CheckK8sMaster {
    script "curl -k https://$VIP_IP:6443"
    interval 3
    timeout 9
    fall 2
    rise 2
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 61
    priority 100
    advert_int 1
    mcast_src_ip $CP1_IP
    nopreempt
    authentication {
        auth_type PASS
        auth_pass sqP05dQgMSlzrxHj
    }
    unicast_peer {
        $CP2_IP
        $CP3_IP
    }
    virtual_ipaddress {
        $VIP_IP/24
    }
    track_script {
        CheckK8sMaster
    }

}
EOF

cat <<EOF > keepalived.conf.master2
global_defs {
   router_id LVS_k8s
}

vrrp_script CheckK8sMaster {
    script "curl -k https://$VIP_IP:6443"
    interval 3
    timeout 9
    fall 2
    rise 2
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 61
    priority 90
    advert_int 1
    mcast_src_ip $CP2_IP
    nopreempt
    authentication {
        auth_type PASS
        auth_pass sqP05dQgMSlzrxHj
    }
    unicast_peer {
        $CP1_IP
        $CP3_IP
    }
    virtual_ipaddress {
        $VIP_IP/24
    }
    track_script {
        CheckK8sMaster
    }

}
EOF

cat <<EOF > keepalived.conf.master3
global_defs {
   router_id LVS_k8s
}

vrrp_script CheckK8sMaster {
    script "curl -k https://$VIP_IP:6443"
    interval 3
    timeout 9
    fall 2
    rise 2
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 61
    priority 80
    advert_int 1
    mcast_src_ip $CP3_IP
    nopreempt
    authentication {
        auth_type PASS
        auth_pass sqP05dQgMSlzrxHj
    }
    unicast_peer {
        $CP1_IP
        $CP2_IP
    }
    virtual_ipaddress {
        $VIP_IP/24
    }
    track_script {
        CheckK8sMaster
    }

}
EOF
