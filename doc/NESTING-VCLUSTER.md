# FLUX

## Requirements

* Kubernetes cluster (K3d/Kind/K3s)
* Flux bootstrap
* Github repositories
    - flux-gitops-infra (can be renamed just for your needs) with fresh cluster configuration
    - deploy-vcluster
    - flux-vcluster
    - sample-apps-deploy
    - sample-apps

### Bootstrap flux 2
Refer to external [repo](https://github.com/devopsapp84/flux-gitops-infra).

```
flux bootstrap github --owner=$GH_FLUX_USER \
--repository=flux-gitops-infra \
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