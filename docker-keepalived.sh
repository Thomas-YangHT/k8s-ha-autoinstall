
#--privileged=true \

docker run --net=host \
--cap-add=NET_ADMIN \
--name keepalived \
-v $HOME/coreos-k8s/$KEEPCONF:/etc/keepalived/keepalived.conf \
-v $HOME/coreos-k8s/keep.sh:/etc/keepalived/keep.sh \
--restart=always \
-d keepalived bash /etc/keepalived/keep.sh
