source ./CONFIG

[ -f /usr/local/bin/cfssl ] || (wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 && \
chmod +x cfssl_linux-amd64 && \
mv cfssl_linux-amd64 /usr/local/bin/cfssl)

[ -f /usr/local/bin/cfssljson ] || (wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 && \
chmod +x cfssljson_linux-amd64 && \
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson)

[ -f /usr/local/bin/cfssl-certinfo ] || (wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 && \
chmod +x cfssl-certinfo_linux-amd64 && \
mv cfssl-certinfo_linux-amd64 /usr/local/bin/cfssl-certinfo)

[ -d ssl ] || mkdir ssl
cd ssl
cat >  ca-config.json <<EOF
{
"signing": {
"default": {
  "expiry": "8760h"
},
"profiles": {
  "kubernetes-Soulmate": {
    "usages": [
        "signing",
        "key encipherment",
        "server auth",
        "client auth"
    ],
    "expiry": "8760h"
  }
}
}
}
EOF

cat >  ca-csr.json <<EOF
{
"CN": "kubernetes-Soulmate",
"key": {
"algo": "rsa",
"size": 2048
},
"names": [
{
  "C": "CN",
  "ST": "shanghai",
  "L": "shanghai",
  "O": "k8s",
  "OU": "System"
}
]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

cat > etcd-csr.json <<EOF
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "$CP1_IP",
    "$CP2_IP",
    "$CP3_IP"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "shanghai",
      "L": "shanghai",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes-Soulmate etcd-csr.json | cfssljson -bare etcd
