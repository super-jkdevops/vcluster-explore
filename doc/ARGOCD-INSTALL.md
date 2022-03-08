# FLUX

## Requirements

* Kubernetes cluster (K3d/Kind/K3s)
* Flux bootstrap
* Github repositories
    - flux-gitops-infra - bootstrap cluster with applications
    - argoapps          - collection of argoCD apps such as Istio, Cert Manager, Kubeseal
    - vcluster-demo     - main repository contains all data how to proceed with vcluster

### Bootstrap flux 2 within host cluster (real one!)
Refer to external [repo](https://github.com/devopsapp84/flux-gitops-infra).

```
flux bootstrap github --owner=$GH_FLUX_USER \
--repository=flux-fleet-platform \
--branch=main \
--path=./clusters/vcluster-demo \
--owner=devopsapp84 \
--log-level=debug \
--network-policy=false \
--author-email="janusz.kujawa@gmail.com" \
--author-name="Janusz Kujawa" \
--components-extra=image-reflector-controller,image-automation-controller 
```

!Adjust params according to your configuration!

`Above command will install Argocd in argo way apps of apps`

### bootstrap flux 2 within 2 virtual clusters (vcluster-a/vcluster-b)
Deploy ArgoCD across vCluster-a and vCluster-b using flux infrastructure.

#### vcluster-a
```
flux bootstrap github --kubeconfig tmp/vcluster-a-kubeconfig-team-c.yaml \
  --owner=$GH_FLUX_USER \
  --repository=flux-fleet-platform \
  --branch=main \
  --path=./clusters/vcluster-demo-a \
  --owner=devopsapp84 \
  --log-level=debug \
  --network-policy=false \
  --author-email="janusz.kujawa@gmail.com" \
  --author-name="Janusz Kujawa" \
  --components-extra=image-reflector-controller,image-automation-controller 
```

#### vcluster-b
```
flux bootstrap github --kubeconfig tmp/vcluster-b-kubeconfig-team-c.yaml \
  --owner=$GH_FLUX_USER \
  --repository=flux-fleet-platform \
  --branch=main \
  --path=./clusters/vcluster-demo-b \
  --owner=devopsapp84 \
  --log-level=debug \
  --network-policy=false \
  --author-email="janusz.kujawa@gmail.com" \
  --author-name="Janusz Kujawa" \
  --components-extra=image-reflector-controller,image-automation-controller 
```