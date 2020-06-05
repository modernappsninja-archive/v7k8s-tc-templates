#!/bin/bash
ETCD01=etcd-tkc01-mm-small-control-plane-5r84b
ETCD02=etcd-tkc01-mm-small-control-plane-9psd7
ETCD03=etcd-tkc01-mm-small-control-plane-pndr8

mkdir -p etcd-secrets/keys && mkdir -p etcd-secrets/certs
kubectl cp kube-system/$ETCD01:/etc/kubernetes/pki/etcd/ca.crt etcd-secrets/etcd-ca
kubectl cp kube-system/$ETCD01:/etc/kubernetes/pki/etcd/healthcheck-client.key etcd-secrets/keys/${ETCD01}-healthcheck-client.key
kubectl cp kube-system/$ETCD01:/etc/kubernetes/pki/etcd/healthcheck-client.crt etcd-secrets/certs/${ETCD01}-healthcheck-client.crt
kubectl cp kube-system/$ETCD02:/etc/kubernetes/pki/etcd/healthcheck-client.key etcd-secrets/keys/${ETCD02}-healthcheck-client.key
kubectl cp kube-system/$ETCD02:/etc/kubernetes/pki/etcd/healthcheck-client.crt etcd-secrets/certs/${ETCD02}-healthcheck-client.crt
kubectl cp kube-system/$ETCD03:/etc/kubernetes/pki/etcd/healthcheck-client.key etcd-secrets/keys/${ETCD03}-healthcheck-client.key
kubectl cp kube-system/$ETCD03:/etc/kubernetes/pki/etcd/healthcheck-client.crt etcd-secrets/certs/${ETCD03}-healthcheck-client.crt
cat etcd-secrets/certs/*.* > etcd-secrets/etcd-client
cat etcd-secrets/keys/*.* > etcd-secrets/etcd-client-key

kubectl -n monitoring create secret generic etcd-client --from-file=etcd-secrets/etcd-ca --from-file=etcd-secrets/etcd-client --from-file=etcd-secrets/etcd-client-key
