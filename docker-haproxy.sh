docker run --name haproxy \
-v $HOME/coreos-k8s/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
-p 8443:8443 \
-p 9090:9090 \
--restart=always \
-d haproxy
