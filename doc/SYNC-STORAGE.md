# Syncing storage
There was several changes in terms of 0.7.0 version released

```
vcluster will now sync storage classes from the virtual cluster to the host cluster if sync of storage classes is enabled. This will replace the current behaviour where storage classes where only synced from host to virtual cluster.

We decided to replace the existing behaviour, because creating storage classes is a valid use case as long as the CSI driver is installed within the host cluster, but certain parameters for the CSI driver should get changed through a storage class. It also makes sense to not sync created storage classes from the host cluster anymore as this is not required to schedule persistent volume claims and currently just has informational purposes.

This is somewhat a breaking change as vclusters that currently have sync of storage classes enabled would now behave differently moving forward as changes to the host cluster storage classes are not propagated anymore. However migration should work as expected, as created storage classes within vcluster that mirrored host cluster storage classes before would just get created in the host cluster under a different name.
```


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
It is fully transparent. Storage provisioned on vcluster is no more affecting host cluster.
This approach is really cool for testing storage provisioner itself and creating sandboxes.
This approach is moving responsibility for storeg to vcluster owners.

ArgoCD app values:

```yaml
- name: sync.persistentvolumeclaims.enabled
  value: 'true'

- name: sync.fake-persistentvolumes.enabled
  value: 'true'

- name: sync.persistentvolumes.enabled
  value: 'false'

- name: sync.storageclasses.enabled
  value: 'false'
```


I assume that your vCluster has deployed then exposed through istio ingress gateway.

#### Installing local-path-provisioner from Rancher

***clone repository:***
```console
git -C /tmp/ clone https://github.com/rancher/local-path-provisioner
```

***Install storage path provisioner in kube-system***
```console
$ vcluster connect -n k3s vcluster-k3s-123 -- helm install local-path --namespace kube-system /tmp/local-path-provisioner/deploy/chart --set storageClass.defaultClass=true

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
```console
$ kubectl apply -f manifests/samples/test-storage-pod.yaml \
	-f manifests/samples/test-storage-pvc.yaml \
        --kubeconfig=./tmp/kubeconfig-vcluster-k3s-123.yaml

pod/volume-test created
persistentvolumeclaim/persistent-volume-claim created
```

#### Verify process

Checking host cluster, vcluster exists within k3s namespace:

```console
$ kubectl get pvc,pv -n k3s

NAME                                                                         STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-vcluster-k3s-123-0                                Bound    pvc-c89a9fe3-f29d-4076-b702-a5d3a5246d9d   5Gi        RWO            local-path     4m35s
persistentvolumeclaim/persistent-volume-claim-x-default-x-vcluster-k3s-123   Bound    pvc-e46fd86d-a183-46ac-84e0-c7f50f0b9713   1Gi        RWO            local-path     2m53s

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                      STORAGECLASS   REASON   AGE
persistentvolume/pvc-c89a9fe3-f29d-4076-b702-a5d3a5246d9d   5Gi        RWO            Delete           Bound    k3s/data-vcluster-k3s-123-0                                local-path              4m32s
persistentvolume/pvc-e46fd86d-a183-46ac-84e0-c7f50f0b9713   1Gi        RWO            Delete           Bound    k3s/persistent-volume-claim-x-default-x-vcluster-k3s-123   local-path              2m51s
```
