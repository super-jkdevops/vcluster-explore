# Add Vcluster to ArgoCD
Before you start make sure that you have already deployed any Vcluster within your K3d instance


## 2 directions
Thera are 2 ways accessing Vcluster from ArgoCD using Istio ingress or just local service within vcluster namespace

```bash
Be aware!
```
Make sure that your Vcluster argoCD app manifest contains proper san entries, otherwise you will get Unknown Certification Authority error!

For example `vcluster-k8s-123` scenario has this params:
```yaml

- name: syncer.extraArgs
  value: '{--tls-san=vcluster-k8s-123.172.27.0.3.nip.io,vcluster-k8s-123.k8s.svc.cluster.local}'
```

As you can see 2 hosts entries are used for 1st for ingress 2nd for local access.
Make note your INGRESS IP may be different cause different K3d subnet...

## Istio
Below listing from part of secret manifest contains kubeconfig values. If you need more explanation have look on [ArgoCD doc](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters)

```yaml
.
..
...
stringData:
  name: vcluster-k8s-123-ing
  server: https://vcluster-k8s-123.172.27.0.3.nip.io
  config: |
.
..
...

```



## Local
```yaml
.
..
...
stringData:
  name: vcluster-k8s-123-loc
  server: https://vcluster-k8s.k8s.svc.cluster.local
  config: |
.
..
...
```

## Add servers in declarative way
TBD
