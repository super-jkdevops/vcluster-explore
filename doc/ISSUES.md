# Knowing issue

## Deleting argocd application with particular vcluster scenario doesn't remove vcluster configmaps and certificates

### Background

```shell
$ kubectl depete -f scenarios/argo/selective-sync/k8s/vcluster-k8s-121-no-sync-all.yaml

$ kubectl get po,deployment,svc,cm,secret -n k8s
NAME                                                         DATA   AGE
configmap/kube-root-ca.crt                                   1      17m
configmap/istio-ca-root-cert                                 1      17m
configmap/vcluster-vcluster-k8s-121-no-sync-all-controller   0      16m

NAME                                        TYPE                                  DATA   AGE
secret/default-token-vxpqw                  kubernetes.io/service-account-token   3      17m
secret/vcluster-k8s-121-no-sync-all-certs   Opaque                                24     17m
```

### Workaround
Delete namespace accordingly

```console
kubectl delete <namespace>
```
