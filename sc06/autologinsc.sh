#!/bin/bash 
# v0.0.1
# Comment out exports if setting ENV variable with CI/CD pipeline
export SC_CLUS_VIP="10.10.20.129"
export SC_USER_NAME="administrator@vsphere.local"
export SC_USER_PASS="VMware1!"

/usr/bin/expect <(cat << EOF
spawn kubectl vsphere login --server=10.10.20.129 --vsphere-username administrator@vsphere.local --managed-cluster-namespace demo-ns1 --managed-cluster-name tkc3 --insecure-skip-tls-verify
expect "Password:"
send "$::env(SC_USER_PASS)\n"
interact
EOF
)
sleep 5
kubectl config set-context tkc3
sleep 3
kubectl get po -ns jenkins 
sleep 30

#kubectl config set-context tkc3

