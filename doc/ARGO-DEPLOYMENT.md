# ArgoCD Deployment

## Requirements

* Kubernetes Cluster (K3d/Kind/K3s/K8s/AKS/GKE/EKS)
* ArgoCD installed and configured within Kubernetes
* Istio installed and configured (ArgoCD approaches)

## Applying manifests
2 available options:

### Loadbalancer
```
kubectl apply -f manifests/common/project.yaml
kubectl apply -f manifests/argocd/vcluster/application-lb.yaml
```
#### Accessing cluster


### Ingress (Istio)
```
kubectl apply -f manifests/argocd/common/project.yaml
kubectl apply -f manifests/istio
kubectl apply -f manifests/argocd/vcluster/application-ing.yaml
```

#### Accessing cluster 

```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

vcluster connect vcluster -n vcluster --server=https://vcluster.vcluster.$INGRESS.nip.io
```

**Output:**
```
[info]   Use `vcluster connect vcluster -n vcluster -- kubectl get ns` to execute a command directly within this terminal
[done] √ Virtual cluster kube config written to: ./kubeconfig.yaml. You can access the cluster via `kubectl --kubeconfig ./kubeconfig.yaml get namespaces`
```

Output may be different it depend on your configuration


