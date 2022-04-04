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

I highly recommend to use local way just to avoid unnecessary paterns creation (easy setup!).

## Istio
Below listing from part of secret manifest contains kubeconfig values. If you need more explanation have look on [ArgoCD doc](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters)

### Manually
Create manifest based on above documentation link  and fire up kubectl apply -f

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

### Script
*Before you run utils/add-vcluster.sh*

```
export INGRESS=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')
export VCLUSTER=<your vcluster name>
export VCLUSTER_NS=<vcluster namespace reside>
export VCLUSTER_URL="https://$VCLUSTER.$INGRESS.nip.io"
```

---

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
### Manually
Create manifest based on above documentation link then fire up kubectl apply -f

### Script
*Before you run utils/add-vcluster.sh*

```
export VCLUSTER=<your vcluster name>
export VCLUSTER_NS=<vcluster namespace reside>
```

Run script:
```bash
utils/add-vcluster.sh

namespace is present let's continue
OK: vcluster exists within given vcluster name
secret/vcluster-k8s-123 configured
``
