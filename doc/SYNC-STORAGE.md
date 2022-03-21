# Syncing storage

## Requirements
Adjust storage configuration for vcluster. Below example took very easy one [local-path-provisioner](https://github.com/rancher/local-path-provisioner)

- [X] vCluster deployed, configured and accessibled
- [X] Storage provisioner deployed (local-path-storage is enought for testing)
- [X] Sample application that is using storage definitions


### Host cluster
Storage classs is synced on vcluster from host cluster. This become not so transparent.
It can affect main Kubernetes cluster. It may be also required some steps for the host cluster 
admins to deliver specific config for vcluster.

If your vCluster was deployed under k3d you don't need to install any storage provisioner however if you want
test different storage then you can.

### Fake node cluster
It is fully transparent. Storage provisioned on vcluster is no more presented on host cluster.
This approach is really cool for testing storage provisioner itself and creating sandboxes.
This approach is moving responsibility for storeg to vcluster owners.

I assume that your vCluster has deployed then exposed through istio ingress gateway.

#### Installing local-path-provisioner from Rancher

***clone repository:***
```
git -C /tmp/ clone https://github.com/rancher/local-path-provisioner
```

***Install storage path provisioner in kube-system***
```
vcluster connect -n tests vcluster -- helm install local-path --namespace kube-system /tmp/local-path-provisioner/deploy/chart -v storageClass.defaultClass=true
```
