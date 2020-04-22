#!/bin/bash 
#csaroka@vmware.com
#v0.0.1
# Comment out variables if setting ENV variable with CI/CD pipeline
export SC_CLUS_VIP="192.168.161.1"
export SC_USER_NAME="administrator@vsphere.local"
export SC_USER_PASS="VMware1!"

/usr/bin/expect <(cat << EOF
spawn kubectl vsphere login --server=$::env(SC_CLUS_VIP) --vsphere-username $::env(SC_USER_NAME) --insecure-skip-tls-verify
expect "Password:"
send "$::env(SC_USER_PASS)\n"
interact
EOF
)
