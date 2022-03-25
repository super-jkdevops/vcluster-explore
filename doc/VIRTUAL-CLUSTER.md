### Creating sample cluster
Can be installed on K3s or Kind. Exposing cluster to
public (external access) required Loadbalancer configuration.

For testing purpose I encourage to use k3d.

`Make note!`
Your k3d cluster can have different name cause I used preaviously created one.
I created this document in realy early stage so may not reflect name convention from
scenarios directory. 


**Assumptions**
namespace:    team-a
cluster name: vcluster

#### Variants:
There are several variants installation

**Without exposing**
```
vcluster create vcluster -n team-a
```

**Exposing externally using LB**
```
vcluster create vcluster -n team-a --expose
```


**With additional configuration**
```
vcluster create vcluster -n team-a -f values.yaml
```

#### Sample values file
```
serviceCIDR: "10.43.0.1/12"
vcluster:
  image: rancher/k3s:v1.23.3-k3s1   
service:
  type: LoadBalancer
```

#### Declarative way Argo/Flux

**Explore**

*Knowing Service CIDR*
This is important cause this value need to be put into vcluster.yaml (helm values).
Usually value is different for variety of Kubernetes CNI (Calico/Flannel/WeaveNet)

```
SVC_CIDR=$(echo '{"apiVersion":"v1","kind":"Service","metadata":{"name":"tst"},"spec":{"clusterIP":"1.1.1.1","ports":[{"port":443}]}}' | kubectl apply -f - 2>&1 | sed 's/.*valid IPs is //')
echo $SVC_CIDR 
```

*Add repository*

```
helm repo add vcluster https://charts.loft.sh/
helm repo update vcluster
```

*Available versions*
```
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                 
vcluster/vcluster       0.6.0                           vcluster - Virtual Kubernetes Clusters      
vcluster/vcluster       0.5.3                           vcluster - Virtual Kubernetes Clusters      
vcluster/vcluster       0.5.2                           vcluster - Virtual Kubernetes Clusters      
.
..
...
vcluster/vcluster-k8s   0.5.0                           vcluster - Virtual Kubernetes Clusters (k8s)
``` 

Checked by helm repo 

Trying imperative way (testing)

**Deploy**:
```
helm install vcluster vcluster/vcluster -n team-a --create-namespace -f ./defaults/vcluster.yaml
```

![vcluster-a spinup](../doc/images/vcluster-a-install.gif)

It can take a while up to 2 mins cause it depends on Internet speed (pull images process)


**Use**:

Connect:
```
vcluster connect vcluster-a -n team-a
export KUBECONFIG=./kubeconfig.yaml
```
![vcluster-a spinup](../doc/images/vcluster-a-connect.gif)

Permanently, update default kubeconfig (~/.kube/config):
```
vcluster connect vcluster -n team-a --update-current
```
![vcluster-a spinup](../doc/images/vcluster-a-update-current.gif)

**Distinguish**

Virtual:
```
kkubectl get no -o wide
NAME                        STATUS   ROLES    AGE   VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                KERNEL-VERSION      CONTAINER-RUNTIME
k3d-vcluster-poc-server-0   Ready    <none>   34s   v1.23.3+k3s1   10.43.234.204   <none>        Fake Kubernetes Image   4.19.76-fakelinux   docker://19.3.12
```

Host:
```
kubectl get no  -o wide
NAME                        STATUS   ROLES                  AGE     VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE   KERNEL-VERSION     CONTAINER-RUNTIME
k3d-vcluster-poc-agent-0    Ready    <none>                 3m49s   v1.22.6+k3s1   172.31.0.2    <none>        K3s dev    5.4.0-99-generic   containerd://1.5.9-k3s1
k3d-vcluster-poc-agent-1    Ready    <none>                 3m48s   v1.22.6+k3s1   172.31.0.4    <none>        K3s dev    5.4.0-99-generic   containerd://1.5.9-k3s1
k3d-vcluster-poc-server-0   Ready    control-plane,master   3m54s   v1.22.6+k3s1   172.31.0.3    <none>        K3s dev    5.4.0-99-generic   containerd://1.5.9-k3s1
```

In first example OS-IMAGE is `Fake Kubernetes Image` what point exact to virtual cluster.
<br/>
Second example concerns real node cluster OS-IMAGE field indicate K3D cluster image that came from.
