from fabric.api import *

def test():
    get('coreos-k8s/master-conf.tgz','master-conf.tgz')

def reset():
   # with cd("$HOME/coreos-k8s"):
   #     run("ls")
    run('sudo -i kubeadm reset -f ')
    run('sudo rm -rf /etc/kubernetes')

def prepare():
  #  run('export PATH=$PATH:/opt/bin')
  #  run('sudo -i kubeadm reset -f ')
    put('coreos-k8s.tgz', '')
    run('mkdir coreos-k8s;tar  -C coreos-k8s -zxvf coreos-k8s.tgz')
    #run('mkdir coreos-k8s;tar --wildcards -zxvf coreos-k8s.tgz --exclude=*tar -C coreos-k8s')
    run('rm coreos-k8s.tgz')
    run('ls coreos-k8s')
    run('ls coreos-k8s/*tar |awk \'{print "docker load <"$1}\'|sh')
    #run('tar --wildcards -zxvf coreos-k8s.tgz *tar |docker load')
    run('docker images')
    run('sudo mkdir -p /opt/{bin,cni/bin}')
    run('sudo tar -C /opt/cni/bin -xzvf coreos-k8s/cni-plugins-amd64-v0.6.0.tgz')
    run('sudo cp $HOME/coreos-k8s/{kubeadm,kubelet,kubectl} /opt/bin;ls -l /opt/*')
    run('sudo chmod +x /opt/bin/{kubeadm,kubelet,kubectl};ls -l /opt/*')
    run('sed -i \'s#PATH=.*#PATH=$PATH:/opt/bin#g\' $HOME/.bash_profile')
    run('sed -i \'$a export PATH=$PATH:/opt/bin\' $HOME/.bashrc')
    run('sudo mkdir -p /etc/systemd/system/kubelet.service.d;pwd')
    run('sudo cp  coreos-k8s/kubelet.service  /etc/systemd/system/kubelet.service')
    run('sudo cp  coreos-k8s/10-kubeadm.conf  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf')
    run('sudo systemctl enable kubelet && sudo systemctl start kubelet')
    run('rm coreos-k8s/*tar')

#for ha
def prepare_ha():
    local('sh haproxy_conf.sh')
    local('sh hosts_conf.sh')
    local('sh calico.sh')
   #local('sh keepalive_conf.sh')
    local('sh kubeadm_config.sh')
    local('sleep 2;tar zcvf config.tgz  hosts haproxy.cfg m1_ca_files docker*.sh  CONFIG ssl kubeadm-config.yaml calico kubeadm-init.sh')
    put('config.tgz','')
    put('ha.tgz', '')
    run('ls ha.tgz config.tgz|xargs -n 1 tar -C coreos-k8s -zxvf')
    run('rm ha.tgz config.tgz')
    run('echo -e "haproxy.tar\n keepalived.tar\n etcd.tar"|awk \'{print "docker load <coreos-k8s/"$1}\'|sh')
    run('[ -f hosts.bak ] || cp /etc/hosts hosts.bak;cat hosts.bak coreos-k8s/hosts >hosts.tmp;sudo cp hosts.tmp /etc/hosts')
   # run('sudo mkdir /etc/kubernetes;sudo cp -r coreos-k8s/ssl /etc/kubernetes/')
    run('sudo mkdir /etc/etcd;sudo cp -r coreos-k8s/ssl /etc/etcd/')
    run('rm coreos-k8s/*tar')

#for ha
def keepalived():
    run('docker rm keepalived -f;pwd')
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('cd coreos-k8s;sh docker-keepalived.sh')

#for ha
def haproxy():
    run('docker rm haproxy -f;pwd')
    run('sh coreos-k8s/docker-haproxy.sh')

#for ha
def etcd():
    run('docker rm etcd-${HOSTNAME} -f;pwd')
    run('sudo rm -rf /var/lib/etcd')
    run('sh coreos-k8s/docker-etcd.sh')

def master():
    run('export PATH=$PATH:/opt/bin')
    run('sudo -i kubeadm reset -f ')
   # run('sudo -i kubeadm init --kubernetes-version=v1.12.1 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=0.0.0.0')
    run('cd coreos-k8s;sudo sh kubeadm-init.sh')
    run('mkdir -p $HOME/.kube')
    run('sudo cp  /etc/kubernetes/admin.conf $HOME/.kube/config')
    run('sudo chown $(id -u):$(id -g) $HOME/.kube/config')

#for HA master1
def master1():
    run('export PATH=$PATH:/opt/bin')
    run('sudo -i kubeadm reset -f ')
    run('sudo  kubeadm init  --config ~/coreos-k8s/kubeadm-config.yaml --upload-certs')
    run('sudo tar zcvf coreos-k8s/master-conf.tgz -T coreos-k8s/m1_ca_files')
    run('mkdir -p $HOME/.kube')
    run('sudo cp  /etc/kubernetes/admin.conf $HOME/.kube/config')
    run('sudo chown $(id -u):$(id -g) $HOME/.kube/config')
    get('coreos-k8s/master-conf.tgz','master-conf.tgz')
   # run('sudo cp -r /var/lib/etcd ./etcd`date +%s`')

#for HA master2&3
def master2():
    local('cat log |grep -Po "kubeadm join.*|--discovery-token.*|--control-plane.*"|head -n 5|tail -n 2  >join.sh')
    local('cat log |grep -Po "kubeadm join.*|--discovery-token.*|--control-plane.*"|head -n 3  >joinMaster.sh')
    run('sudo /opt/bin/kubeadm reset -f ')
    put('master-conf.tgz','')
    run('sudo rm -rf /etc/kubernetes')
    run('sudo tar zxvf master-conf.tgz -C /etc --strip-components 1')
    run('sudo rm -f /etc/kubernetes/pki/ca.crt')
    run('mkdir -p $HOME/.kube')
    run('sudo cp  /etc/kubernetes/admin.conf $HOME/.kube/config')
    run('sudo chown $(id -u):$(id -g) $HOME/.kube/config')
    run('sudo mkdir /root/.kube;sudo ls /root/.kube')
    run('sudo cp /etc/kubernetes/admin.conf /root/.kube/config')
   # run('echo "export PATH=$PATH:/opt/bin">>.bashrc')
   # run('sudo cp bashrc /root/.bashrc')
    put('joinMaster.sh','')
    run('sudo chmod +x ./joinMaster.sh')
    run('sudo ./joinMaster.sh')

def flannel():
    run('kubectl taint nodes --all  node-role.kubernetes.io/master-')
    run('kubectl apply -f coreos-k8s/kube-flannel.yml')

def calico():
    run('kubectl taint nodes --all  node-role.kubernetes.io/master-;ls')
   # run('kubectl apply -f  coreos-k8s/calico/etcd-calico-deploy.yaml')
   # run('kubectl apply -f  coreos-k8s/calico/rbac.yaml')
    run('kubectl apply -f  coreos-k8s/calico/calico.yaml')
   # run('kubectl delete -f coreos-k8s/kube-flannel.yml;ls')

def dashboard():
    #run('sed -i "/^\  ports:/i \  type: NodePort"  coreos-k8s/dashboard-recommended.yaml')
    run('kubectl apply -f  coreos-k8s/dashboard-recommended.yaml')
    run('kubectl apply -f  coreos-k8s/dashboard-adminuser.yaml')
    run('kubectl apply -f  coreos-k8s/metrics-server')

def node():
    put('join.sh','')
    run('sudo chmod +x ./join.sh')
    run('sudo -i kubeadm reset -f')
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('sudo ./join.sh')

def rejoin():
    run('kubeadm token create --print-join-command')
    local('cat log |grep -Po "kubeadm join.*|--discovery-token.*|--control-plane.*"  >join.sh')

def addon():
    put('k8s-addon.tgz', '')
    run('tar zxvf k8s-addon.tgz')
    run('rm k8s-addon.tgz')
    run('ls k8s-addon/*tar |awk \'{print "docker load <"$1}\'|sh')
    run('rm k8s-addon/*tar')

def ingress():
    run('tar zxvf k8s-addon/ingress-nginx.tgz -C k8s-addon/')
    run('sed -i "/- --anno/a \            - --enable-ssl-passthrough" k8s-addon/ingress-nginx/deploy/mandatory.yaml ')
    run('kubectl apply -f  k8s-addon/ingress-nginx/deploy/mandatory.yaml')
    run('kubectl apply -f  k8s-addon/ingress-nginx/deploy/provider/baremetal/service-nodeport.yaml')
    run('kubectl apply -f  k8s-addon/ingress-dashboard.yml')
    run('kubectl get ingress --all-namespaces')

def helm():
    run('tar zxvf coreos-k8s/helm-v3.0.3-linux-amd64.tar.gz -C coreos-k8s/')
    run('sudo cp coreos-k8s/linux-amd64/helm /opt/bin/helm3')
    run('tar zxvf coreos-k8s/helm-v2.16.1-linux-amd64.tar.gz -C coreos-k8s/')
    run('sudo cp coreos-k8s/linux-amd64/helm /opt/bin/helm')
    run('helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.16.1 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts')
    run('kubectl create serviceaccount --namespace kube-system tiller')
    run('kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller')
    run('kubectl patch deploy --namespace kube-system tiller-deploy -p \'{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}\'')
    run('kubectl get pods --all-namespaces')
    run('helm repo add apphub https://apphub.aliyuncs.com/ && \
         helm repo add aliyun https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts && \
         helm repo add microsoft  http://mirror.azure.cn/kubernetes/charts')

def prometheus():
    run('kubectl apply -f  k8s-addon/prometheus/')

def efk():
    run('L=`cat k8s-addon/efk/kibana-deployment.yaml |grep -n SERVER_BASEPATH|awk -F\':\' \'{print $1+1}\'` &&  \
sed  -i "$L s/.*/#\\0/" k8s-addon/efk/kibana-deployment.yaml ')
  #Because fluentd's pod cost plenty of system performance,
  #pods of fluentd not running by default,
  #you can uncomment follow two lines  '#' to run pods of fluentd or set nodeSelector  manually.
  #  run('L=`cat k8s-addon/efk/fluentd-es-ds.yaml |grep -n nodeSelector|awk -F\':\' \'{print $1+1}\'` && \
  #  sed  -i "$L s/.*/#\\0/" k8s-addon/efk/fluentd-es-ds.yaml')
    run('kubectl apply -f  k8s-addon/efk/')
    run('kubectl set image  daemonset fluentd-es-v2.2.1  fluentd-es=k8s.gcr.io/fluentd-elasticsearch:v2.2.1 -n kube-system')

def istio_prepare():
    put('istio.tgz', '')
    run('tar zxvf istio.tgz')
    run('rm istio.tgz')
    run('ls istio/*tar |awk \'{print "docker load <"$1}\'|sh')
    run('rm istio/*tar')

def istio():
    run('cp istio/istioctl /opt/bin/')
    run('kubectl apply -f istio/install/kubernetes/helm/istio/templates/crds.yaml')
    run('helm template istio/install/kubernetes/helm/istio --name istio --namespace istio-system \
--set sidecarInjectorWebhook.enabled=true \
--set ingress.service.type=NodePort \
--set gateways.istio-ingressgateway.type=NodePort \
--set gateways.istio-egressgateway.type=NodePort \
--set tracing.enabled=true \
--set servicegraph.enabled=true \
--set prometheus.enabled=true \
--set tracing.jaeger.enabled=true \
--set grafana.enabled=true > istio.yaml')
    run('kubectl create namespace istio-system;ls')
    run('kubectl create -f istio.yaml;pwd')

def finish():
    run('kubectl version')
    run('kubectl get svc --all-namespaces -o wide')
    run('kubectl get cs')
    run('kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk \'{print $1}\')')

def getsvc():
    run('kubectl get svc --all-namespaces -o wide')

def gettoken():
    run('kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk \'{print $1}\')')

def reboot():
    run('echo "reboot $HOSTNAME";sudo reboot;:')

#for ha
def etcdcheck():
    run('source coreos-k8s/CONFIG && \
sudo etcdctl \
--cert-file /etc/etcd/ssl/etcd.pem \
--key-file /etc/etcd/ssl/etcd-key.pem \
--ca-file /etc/etcd/ssl/ca.pem \
--endpoints https://$CP1_IP:2379 cluster-health')

def getpods():
    run('kubectl get pods --all-namespaces -o wide')
    run('kubectl get nodes')
    run('kubectl get cs')
    run('kubectl top node;kubectl top pod --all-namespaces')

def calicocheck():
    run('sudo coreos-k8s/calico/calicoctl node status')

def clusterinfo():
    run('kubectl cluster-info')

def timezone8():
    run('sudo timedatectl set-timezone Asia/Shanghai')
    run('date')

def route():
    put('tools/route.sh','')
    run('sh route.sh')

def hosts():
    local('sh hosts_conf.sh')
    put('hosts','coreos-k8s/hosts')
    run('sudo cp coreos-k8s/hosts /etc/hosts')
