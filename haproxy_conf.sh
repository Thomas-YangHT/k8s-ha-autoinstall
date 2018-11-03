source ./CONFIG
cat << EOF > haproxy.cfg
global
  log 127.0.0.1 local0
  log 127.0.0.1 local1 notice
  tune.ssl.default-dh-param 2048

defaults
  log global
  mode http
  option dontlognull
  timeout connect 5000ms
  timeout client  600000ms
  timeout server  600000ms

listen stats
    bind :9090
    mode http
    balance
    stats uri /haproxy_stats
    stats auth admin:admin
    stats admin if TRUE

frontend kube-apiserver-https
   mode tcp
   bind :8443
   default_backend kube-apiserver-backend

backend kube-apiserver-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server master1 $CP1_IP:6443 check
    server master2 $CP2_IP:6443 check
    server master3 $CP3_IP:6443 check
EOF

