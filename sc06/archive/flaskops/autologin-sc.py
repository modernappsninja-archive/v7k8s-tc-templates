#!/usr/bin/python
import pexpect

def main():
    ##child = pexpect.spawn('kubectl vsphere login --server=kubeapi.corp.local --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child = pexpect.spawn('kubectl vsphere login --server=10.10.20.129 --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child.expect('Password:')
    child.sendline('VMware1!')
    child = pexpect.spawn('kubectl get ns')
    err = child.read()
    print err
    child = pexpect.spawn('kubectl get po')
    err = child.read()
    print err

if __name__ == "__main__":
    main()
