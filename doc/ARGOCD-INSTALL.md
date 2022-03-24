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

```bash
flux bootstrap github --owner=$GH_FLUX_USER \
--repository=flux-fleet-platform \
--branch=main \
--path=./clusters/dev \
--owner=devopsapp84 \
--log-level=debug \
--network-policy=false \
--author-email="janusz.kujawa@gmail.com" \
--author-name="Janusz Kujawa" \
--components-extra=image-reflector-controller,image-automation-controller 
```

!Adjust params according to your configuration!

`Above command will install Argocd in argo way apps of apps`

#### vcluster-k8s-123
```bash
flux bootstrap github --kubeconfig tmp/vcluster-k8s-123-kubeconfig.yaml \
  --owner=$GH_FLUX_USER \
  --repository=flux-fleet-platform \
  --branch=main \
  --path=./clusters/vcluster-k8s-123 \
  --owner=devopsapp84 \
  --log-level=debug \
  --network-policy=false \
  --author-email="janusz.kujawa@gmail.com" \
  --author-name="Janusz Kujawa" \
  --components-extra=image-reflector-controller,image-automation-controller 
```
