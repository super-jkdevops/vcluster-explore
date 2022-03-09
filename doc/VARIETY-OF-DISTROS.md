# ArgoCD Deployment

## Requirements

* Kubernetes Cluster (K3d/Kind/K3s/K8s/AKS/GKE/EKS)
* ArgoCD installed and configured within Kubernetes if not try [this](./ARGOCD-INSTALL.md)
* Istio installed and configured (ArgoCD approaches)

### Legend
Each cluster has been created in separate namespace and by ArgoCD deployment

**EKS**: team-e -> vcluster-e<br/>
**K0S**: team-f -> vcluster-f<br/>
**K8S**: team-g -> vcluster-g<br/>

### EKS

```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

kubectl apply -f manifests/argocd/vcluster/eks

kubectl get secret -n team-c vc-vcluster-e -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-e.team-e.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-e-kubeconfig-team-e.yaml
```

### K0s
```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

kubectl apply -f manifests/argocd/vcluster/k0s

kubectl get secret -n team-f vc-vcluster-f -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-f.team-f.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-f-kubeconfig-team-f.yaml
```

### K8s
```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

kubectl apply -f manifests/argocd/vcluster/eks

kubectl get secret -n team-g vc-vcluster-g -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-g.team-g.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-g-kubeconfig-team-g.yaml
```
