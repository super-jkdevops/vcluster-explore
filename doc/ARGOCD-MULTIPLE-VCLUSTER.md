# ArgoCD Deployment

## Requirements

* Kubernetes Cluster (K3d/Kind/K3s/K8s/AKS/GKE/EKS)
* ArgoCD installed and configured within Kubernetes if not try [this](./ARGOCD-INSTALL.md)
* Istio installed and configured (ArgoCD approaches)

## Applying manifests
2 available options:

### Prequisite
Create project
```
kubectl apply -f manifests/argocd/common/project.yaml
```

### Ingress (Istio)
Istio manifests should be applied first (Apps of apps & sync wave under construction!)

```
kubectl apply -f manifests/istio/istio.yaml
```
Then applied ArgoCD project & application:

```
kubectl apply -f manifests/istio/vcluster-gateway.yaml
kubectl apply -f manifests/istio/vcluster-vs-ab.yaml
kubectl apply -f manifests/argocd/vcluster/application-ingress-a.yaml
kubectl apply -f manifests/argocd/vcluster/application-ingress-b.yaml
```

#### Accessing cluster 
Alternatively kubectl instead of vcluster

```
mkdir -p tmp/
kubectl get secret -n team-c vc-vcluster-a -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-a.team-c.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-a-kubeconfig-team-c.yaml
kubectl get secret -n team-c vc-vcluster-b -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-b.team-c.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-b-kubeconfig-team-c.yaml
```


**vcluster-a**
```
kubectl get no --kubeconfig=./tmp/vcluster-a-kubeconfig-team-c.yaml
NAME                         STATUS   ROLES    AGE   VERSION
k3d-vcluster-demo-server-0   Ready    <none>   30m   v1.23.3+k3s1
```

**vcluster-b**
```
kubectl get no --kubeconfig=./tmp/vcluster-b-kubeconfig-team-c.yaml
NAME                        STATUS   ROLES    AGE   VERSION
k3d-vcluster-demo-agent-0   Ready    <none>   38m   v1.23.3+k3s1
```