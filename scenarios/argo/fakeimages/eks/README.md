### Apply

```
kubectl apply -f .
```

### List

#### 1.21
```
$ vcluster connect -n eks vcluster-eks-121 -- kubectl get no
NAME              STATUS   ROLES    AGE   VERSION
k3d-dev-agent-0   Ready    <none>   11m   v1.21.5-eks-1-21
```

#### 1.22
```
$ vcluster connect -n eks vcluster-eks-122 -- kubectl get no
NAME              STATUS   ROLES    AGE     VERSION
k3d-dev-agent-2   Ready    <none>   7m25s   v1.22.6-eks-b18cdc9
```
