### Discrepancies according to documentation.

- [X] vcluster.yaml incorrect syntax
    It should be:
```
serviceCIDR: "10.43.0.1/12"
vcluster:
  image: rancher/k3s:v1.19.5-k3s2 
```

instead

```
vcluster:
  image: rancher/k3s:v1.19.5-k3s2    
  extraArgs:
    - --service-cidr=10.96.0.0/12    
```

- [X] Can not create multiple clusters exposed through LB in one namespace (type: LoadBalancer)

example:

*pod status:*
```
NAME                                                  READY   STATUS              RESTARTS   AGE
svclb-vcluster-a-c6pg8                                1/1     Running             0          72s
svclb-vcluster-a-5dmm7                                1/1     Running             0          72s
svclb-vcluster-a-jtqtw                                1/1     Running             0          72s
vcluster-a-0                                          2/2     Running             0          72s
coredns-687874b9dd-gnj2c-x-kube-system-x-vcluster-a   1/1     Running             0          65s
nginx-demo-5dfc44fcdb-k6vv9-x-demo-x-vcluster-a       1/1     Running             0          65s
svclb-vcluster-aa-g6l6t                               0/1     Pending             0          57s
svclb-vcluster-aa-2fkqm                               0/1     Pending             0          57s
svclb-vcluster-aa-9r5v9                               0/1     Pending             0          57s
vcluster-aa-0                                         0/2     ContainerCreating   0          57s
svclb-vcluster-aaa-5w29b                              0/1     Pending             0          43s
svclb-vcluster-aaa-8cnxl                              0/1     Pending             0          43s
svclb-vcluster-aaa-99m6h                              0/1     Pending             0          43s
vcluster-aaa-0                                        0/2     ContainerCreating   0          43s
```

*service status*:
```
vcluster-a-headless                         ClusterIP      None            <none>                             443/TCP                  82s
vcluster-a                                  LoadBalancer   10.43.77.12     172.30.0.2,172.30.0.3,172.30.0.4   443:30161/TCP            82s
kube-dns-x-kube-system-x-vcluster-a         ClusterIP      10.43.158.219   <none>                             53/UDP,53/TCP,9153/TCP   76s
vcluster-a-node-k3d-vcluster-poc-server-0   ClusterIP      10.43.117.235   <none>                             10250/TCP                73s
vcluster-a-node-k3d-vcluster-poc-agent-1    ClusterIP      10.43.234.31    <none>                             10250/TCP                72s
vcluster-aa-headless                        ClusterIP      None            <none>                             443/TCP                  68s
vcluster-aa                                 LoadBalancer   10.43.188.155   <pending>                          443:32478/TCP            68s
vcluster-aaa-headless                       ClusterIP      None            <none>                             443/TCP                  54s
vcluster-aaa                                LoadBalancer   10.43.146.131   <pending>                          443:32208/TCP            54s
```


### Extract kubeconfig without vcluster commands
Just use standard tools:

- [X] kubectl
- [X] base64

```
kubectl get secret -n team-c vc-vcluster -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster.team-c.'"$INGRESS"'.nip.io/'
```

### Vanilla K8s explore

```
kubectl get secret -n team-h vcluster-h-certs -o jsonpath='{.data.admin\.conf}'  | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/vcluster-h-api.'"$INGRESS"'.nip.io/'
```