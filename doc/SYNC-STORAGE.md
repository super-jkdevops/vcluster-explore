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
$ vcluster connect -n tests vcluster -- helm install local-path --namespace kube-system /tmp/local-path-provisioner/deploy/chart --set storageClass.defaultClass=true

$ vcluster connect -n k3s vcluster-k3s-123 -- helm list -n kube-system
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
local-path      kube-system     1               2022-03-21 12:16:49.830267678 +0100 CET deployed        local-path-provisioner-0.0.21   v0.0.21

$ vcluster connect -n k3s vcluster-k3s-123 -- helm status -n kube-system local-path
NAME: local-path
.
..
...
      storage: 2Gi
```

#### Deploy sample application
```
$ kubectl apply -f manifests/samples/test-storage-pod.yaml \
	-f manifests/samples/test-storage-pvc.yaml \
        --kubeconfig=./tmp/kubeconfig-vcluster-k3s-123.yaml

pod/volume-test created
persistentvolumeclaim/persistent-volume-claim created
```

#### Verify process

Checking host cluster, vcluster exists within k3s namespace:

```
$ kubectl get pvc -n k3s
NAME                      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-vcluster-k3s-123-0   Bound    pvc-b0e1f5e9-40bc-45c5-922a-5bff89185b10   5Gi        RWO            local-path     39m

$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                         STORAGECLASS   REASON   AGE
pvc-b0e1f5e9-40bc-45c5-922a-5bff89185b10   5Gi        RWO            Delete           Bound    k3s/data-vcluster-k3s-123-0   local-path              39m
```

`Storage assignments does not exist within host cluster. Above outputs show only only 1 pv that is for internal vcluster use. Even though vcluster has own storage provisioner it must stores some internal information (config database k3s etc). Please do not mix them!`
