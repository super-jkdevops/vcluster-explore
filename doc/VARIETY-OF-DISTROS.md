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

kubectl get secret -n team-e vc-vcluster-e -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-e.team-e.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-e-kubeconfig-team-e.yaml
```

**status:**

vcluster:
```
$ kubectl get nodes --kubeconfig=./tmp/vcluster-e-kubeconfig-team-e.yaml 
NAME                        STATUS   ROLES    AGE   VERSION
k3d-vcluster-demo-agent-1   Ready    <none>   51m   v1.21.5-eks-1-21
```

host cluster:
```
kubectl get po -n team-e
NAME                                                  READY   STATUS    RESTARTS      AGE
vcluster-e-etcd-0                                     1/1     Running   0             78m
vcluster-e-api-86d976c8f-rfpjs                        1/1     Running   1 (76m ago)   78m
vcluster-e-9bb754d4f-hbv6w                            1/1     Running   2 (76m ago)   78m
vcluster-e-controller-67676587d9-slwsm                1/1     Running   2 (76m ago)   78m
coredns-6c88775df8-bmnqp-x-kube-system-x-vcluster-e   1/1     Running   0             76m
```

---

### K0s
```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

kubectl apply -f manifests/argocd/vcluster/k0s

kubectl get secret -n team-f vc-vcluster-f -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-f.team-f.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-f-kubeconfig-team-f.yaml
```

status:
TBD cause crashes
```
$ kubectl get po -n team-f
NAME           READY   STATUS             RESTARTS      AGE
vcluster-f-0   1/2     CrashLoopBackOff   5 (50s ago)   5m19s
```

---

### K8s
```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')

kubectl apply -f manifests/argocd/vcluster/k8s

kubectl get secret -n team-g vc-vcluster-g -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-g.team-g.'"$INGRESS"'.nip.io/' > ./tmp/vcluster-g-kubeconfig-team-g.yaml
```

**status:**

vcluster
```
$ kubectl get no --kubeconfig=./tmp/vcluster-g-kubeconfig-team-g.yaml  
NAME                        STATUS   ROLES    AGE     VERSION
k3d-vcluster-demo-agent-1   Ready    <none>   2m47s   v1.23.1
```

host cluster:
```
$ kubectl get po -n team-g 
NAME                                                  READY   STATUS    RESTARTS        AGE
vcluster-g-controller-7677ddb597-lnj6g                1/1     Running   0               5m58s
vcluster-g-etcd-0                                     1/1     Running   0               5m57s
vcluster-g-api-749f749df6-cp7tc                       1/1     Running   1 (5m36s ago)   5m59s
vcluster-g-656bb976b8-rfwcf                           1/1     Running   1 (4m47s ago)   5m58s
coredns-687874b9dd-q7cfq-x-kube-system-x-vcluster-g   1/1     Running   0               4m44s
```