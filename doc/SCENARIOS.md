## Samples
You can find here several scenarios of vcluster deployment that can be used for in some cases.

## Name convention acronyms

```
<distro-name>-<type>-<node assignments>-<characteristic>-<accessibled-by>.yaml
```


### Fake k0s single vcluster assigned to specific host node
Can be used for github pipelines.

**host cluster assignment:** k3d-vcluster-demo
**vcluster distro:** k0s
**characteristic:** isolated,no synchronize with nodes
**accessible:** ClusterIP/ISTIO

#### k0s-fk-s-i-ing.yaml

```
vcluster create k0s-fk-s-i-ing -f ./scenarios/k0s-fk-s-i-ing.yaml -n single --distro k0s
kubectl apply -f ./scenarios/istio/k0s-fk-s-i-ing-expose.yaml
```

check:
```
$ vcluster list

 NAME             NAMESPACE   CREATED                                  AGE  
 k0s-fk-s-i-ing   single      2022-03-11 16:13:26.27286503 +0100 CET   13s  

$ k get po -n single
NAME               READY   STATUS    RESTARTS   AGE
k0s-fk-s-i-ing-0   0/2     Pending   0          56s 

$ kubectl label node k3d-vcluster-demo-agent-0 k0s=true

$ kubectl get po -n single
NAME                                                      READY   STATUS    RESTARTS   AGE
k0s-fk-s-i-ing-0                                          2/2     Running   0          4m7s
coredns-687874b9dd-rkwrg-x-kube-system-x-k0s-fk-s-i-ing   1/1     Running   0          14s

$ vcluster connect -n single k0s-fk-s-i-ing -- kubectl get no
NAME                        STATUS   ROLES    AGE   VERSION
k3d-vcluster-demo-agent-1   Ready    <none>   80s   v1.23.3+k0s
```

istio check

```
kubectl get secret -n single k0s-fk-s-i-ing -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/k0s-fk-s-i-ing.single.'"$INGRESS"'.nip.io/' > ./tmp/k0s-fk-s-i-ing-kubeconfig.yaml
```





---

### k8s vanilla multiple nodes synchronized & run across all host cluster nodes

**host cluster assignment:** all availabled nodes
**vcluster distro:** k8s vanilla
**characteristic:** synchronized across all cluster nodes
**accessible:** ClusterIP/ISTIO

k8s-rl-mlt-syn-ing.yaml

---

### high availability k8s vanilla fake multiple nodes run only on worker/agent nodes

**host cluster assignment:** agents/worker nodes
**vcluster distro:** k8s vanilla
**characteristic:** fake nodes with specific image
**accessible:** ClusterIP/ISTIO

k8s-fk-mlt-hi-ing.yaml

---

### k3s single node run on master node with specific affinity rules

**host cluster assignment:** master node
**vcluster distro:** k3s
**characteristic:** synchronized with host nodes
**accessible:** ClusterIP/ISTIO

k3s-fk-sin-af-ing.yaml


### eks multiple node synchronized and runs across all nodes in cluster

**host cluster assignment:** all available nodes
**vcluster distro:** eks
**characteristic:** synchronized with all nodes and objects expect of ingress
**accessible:** ClusterIP/ISTIO

eks-rl-mlt-syn-ing.yaml