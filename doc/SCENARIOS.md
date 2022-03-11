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
kubectl apply -f ./scenarios/istio/k0s-fk-s-i-ing-istio.yaml
```

check:
```
$ vcluster list

 NAME             NAMESPACE   CREATED                                  AGE  
 k0s-fk-s-i-ing   single      2022-03-11 16:13:26.27286503 +0100 CET   13s  

$ kubectl get po -n single
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
kubectl get secret -n single vc-k0s-fk-s-i-ing -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/k0s-fk-s-i-ing.single.'"$INGRESS"'.nip.io/' > ./tmp/k0s-fk-s-i-ing-kubeconfig.yaml

$ kubectl get no --kubeconfig=./tmp/k0s-fk-s-i-ing-kubeconfig.yaml 
NAME                        STATUS   ROLES    AGE   VERSION
k3d-vcluster-demo-agent-1   Ready    <none>   10s   v1.23.3+k0s
```

Alternatively
```
kubectl apply -f ./scenarios/argo/k0s-fk-s-i-ing-argo.yaml
kubectl apply -f ./scenarios/istio/k0s-fk-s-i-ing-istio.yaml
```


---

### k8s vanilla multiple nodes synchronized & run across all host cluster nodes

**host cluster assignment:** all availabled nodes
**vcluster distro:** k8s vanilla
**characteristic:** synchronized across all cluster nodes
**accessible:** ClusterIP/ISTIO

#### k8s-rl-mlt-syn-ing.yaml

```
vcluster create k8s-rl-mlt-syn-ing -f ./scenarios/k8s-rl-mlt-syn-ing.yaml -n multi --distro k8s
kubectl apply -f ./scenarios/istio/k8s-rl-mlt-syn-ing-istio.yaml
```

check:
```
$ vcluster list

 NAME                 NAMESPACE   CREATED                                   AGE    
 k8s-rl-mlt-syn-ing   multi       2022-03-11 17:39:38.936198834 +0100 CET   1m46s  

$ kubectl get po -n multi

k8s-rl-mlt-syn-ing-controller-78f48cf8b5-8h44p   1/1     Running   0             111s
k8s-rl-mlt-syn-ing-etcd-0                        1/1     Running   0             111s
k8s-rl-mlt-syn-ing-75f85cfdd4-xmlxg              0/1     Running   1 (30s ago)   111s
k8s-rl-mlt-syn-ing-api-7b4d657845-gfqxn          1/1     Running   1 (47s ago)   111s

$ vcluster connect -n multi k8s-rl-mlt-syn-ing -- kubectl get no

NAME                         STATUS   ROLES                  AGE   VERSION
k3d-vcluster-demo-agent-0    Ready    <none>                 24s   v1.22.6+k3s1
k3d-vcluster-demo-agent-1    Ready    <none>                 24s   v1.22.6+k3s1
k3d-vcluster-demo-server-0   Ready    control-plane,master   24s   v1.22.6+k3s1

```

istio check

```
$ kubectl get secret -n multi vc-k8s-rl-mlt-syn-ing -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/k8s-rl-mlt-syn-ing.multi.'"$INGRESS"'.nip.io/' > ./tmp/k8s-rl-mlt-syn-ing-kubeconfig.yaml

$ kubectl get no --kubeconfig=./tmp/k8s-rl-mlt-syn-ing-kubeconfig.yaml 
NAME                         STATUS   ROLES    AGE    VERSION
k3d-vcluster-demo-server-0   Ready    <none>   4m6s   v1.22.4
```

Alternatively
```
kubectl apply -f ./scenarios/argo/k8s-rl-mlt-syn-ing-argo.yaml
kubectl apply -f ./scenarios/istio/k8s-rl-mlt-syn-ing-istio.yaml
```

If no all nods will be present then create sample pods:

```
kubectl create deployment app --replicas=3 --image=nginx --kubeconfig=./tmp/k8s-rl-mlt-syn-ing-kubeconfig.yaml 
```

---

### high availability k8s vanilla fake multiple nodes run only on worker/agent nodes

**host cluster assignment:** agents/worker nodes
**vcluster distro:** k8s vanilla
**characteristic:** fake nodes with specific image
**accessible:** ClusterIP/ISTIO

#### k8s-fk-mlt-hi-ing.yaml

```
vcluster create k8s-fk-mlt-hi-ing -f ./scenarios/k8s-fk-mlt-hi-ing.yaml -n multi --distro k8s
kubectl apply -f ./scenarios/istio/k8s-fk-mlt-hi-ing-istio.yaml
```

check:
```
$ vcluster list

 NAME                NAMESPACE   CREATED                                   AGE    
 k8s-fk-mlt-hi-ing   multi       2022-03-11 19:03:57.536514214 +0100 CET   1m17s  

$ kubectl get po -n multi

k8s-rl-mlt-syn-ing-controller-78f48cf8b5-8h44p   1/1     Running   0             111s
k8s-rl-mlt-syn-ing-etcd-0                        1/1     Running   0             111s
k8s-rl-mlt-syn-ing-75f85cfdd4-xmlxg              0/1     Running   1 (30s ago)   111s
k8s-rl-mlt-syn-ing-api-7b4d657845-gfqxn          1/1     Running   1 (47s ago)   111s

$ vcluster connect -n multi k8s-rl-mlt-syn-ing -- kubectl get no

NAME                         STATUS   ROLES                  AGE   VERSION
k3d-vcluster-demo-agent-0    Ready    <none>                 24s   v1.22.6+k3s1
k3d-vcluster-demo-agent-1    Ready    <none>                 24s   v1.22.6+k3s1
k3d-vcluster-demo-server-0   Ready    control-plane,master   24s   v1.22.6+k3s1

```

---

### k3s single node run on master node with specific affinity rules

**host cluster assignment:** master node
**vcluster distro:** k3s
**characteristic:** synchronized with host nodes
**accessible:** ClusterIP/ISTIO

#### k3s-fk-sin-af-ing.yaml

# TBD


### eks multiple node synchronized and runs across all nodes in cluster

**host cluster assignment:** all available nodes
**vcluster distro:** eks
**characteristic:** synchronized with all nodes and objects expect of ingress
**accessible:** ClusterIP/ISTIO

#### eks-rl-mlt-syn-ing.yaml

# TBD