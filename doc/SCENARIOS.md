## Different scenarios according to different distributions

| nr | host distro | virtual distro | image version         | fake node | ha mode | synch mode   | manifests files |
|----|:----------------|:-----------|:----------------------|-----------|---------|--------------|-----------------|
| 1  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.21.9-k3s1     | yes       | no      | only objects | [k3s-v121](../scenarios/argo/fakenodes/k3s/vcluster-k3s-121.yaml)|
| 2  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.22.6-k3s1     | yes       | no      | only objects | [k3s-v122](../scenarios/argo/fakenodes/k3s/vcluster-k3s-122.yaml)|
| 3  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.23.3-k3s1     | yes       | no      | only objects | [k3s-v123](../scenarios/argo/fakenodes/k3s/vcluster-k3s-123.yaml)|
| 4  | k3d/1.22.6+k3s1 | k0s | k0sproject/k0s:v1.22.6-k0s.0 | yes       | no      | only objects | [k0s-v122](../scenarios/argo/fakenodes/k0s/vcluster-k0s-122.yaml)|
| 5  | k3d/1.22.6+k3s1 | k0s | k0sproject/k0s:v1.23.3-k0s.1 | yes       | no      | only objects | [k0s-v123](../scenarios/argo/fakenodes/k0s/vcluster-k0s-123.yaml)|
| 6  | k3d/1.22.6+k3s1 | eks | etcd:v3.4.16-eks-1-21-8, kube-controller-manager:v1.21.5-eks-1-21-8  kube-apiserver:v1.21.5-eks-1-21-8 | yes | yes | only objects | [eks-v121](../scenarios/argo/fakenodes/eks/vcluster-eks-121.yaml)|
| 7  | k3d/1.22.6+k3s1 | eks | etcd:v3.5.1-eks-1-22-1,  kube-controller-manager:v1.22.6-eks-1-22-1, kube-apiserver:v1.22.6-eks-1-22-1 | yes | yes | only objects | [eks-v122](../scenarios/argo/fakenodes/eks/vcluster-eks-122.yaml)|
| 8  | k3d/1.22.6+k3s1 | k8s | etcd:3.4.13-0, kube-controller-manager:v1.21.5, kube-apiserver:v1.21.5 | yes | yes | only objects | [k8s-v121](../scenarios/argo/fakenodes/k8s/vcluster-k8s-121.yaml)|
| 9  | k3d/1.22.6+k3s1 | k8s | etcd:3.5.1-0,  kube-controller-manager:v1.22.4, kube-apiserver:v1.22.4 | yes | yes | only objects | [k8s-v122](../scenarios/argo/fakenodes/k8s/vcluster-k8s-122.yaml)|
| 10 | k3d/1.22.6+k3s1 | k8s | etcd:3.5.1-0,  kube-controller-manager:v1.23.1, kube-apiserver:v1.23.1 | yes | yes | only objects | [k8s-v123](../scenarios/argo/fakenodes/k8s/vcluster-k8s-123.yaml)|
| 11 | k3d/1.22.6+k3s1 | k8s | etcd:3.5.1-0,  kube-controller-manager:v1.23.4, kube-apiserver:v1.23.4 | yes | yes | only objects | [k8s-v123-4](../scenarios/argo/fakenodes/k8s/vcluster-k8s-123-4.yaml)|

* ha mode   - enable high availability cluster components multiple API server, backend database, controllers etc
* sync mode - for fake clusters node synchronization stay disable on all dinmentions

## Images reference

### Base Images 
Each vcluster release is provided together with bunch of images that are supported.

Accordingly the official images list can be found in each github release:

*v0.6.0*: https://github.com/loft-sh/vcluster/releases/download/v0.6.0/vcluster-images.txt

For earlier release just check [releases list ](https://github.com/loft-sh/vcluster/releases)


*v0.6.0*
```
loftsh/vcluster:0.6.0
library/alpine:3.13.1

rancher/k3s:v1.16.15-k3s1
rancher/k3s:v1.23.3-k3s1
rancher/k3s:v1.22.6-k3s1
rancher/k3s:v1.21.9-k3s1
rancher/k3s:v1.20.15-k3s1
rancher/k3s:v1.19.13-k3s1
rancher/k3s:v1.18.20-k3s1
rancher/k3s:v1.17.17-k3s1

k0sproject/k0s:v1.23.3-k0s.0
k0sproject/k0s:v1.22.6-k0s.0

k8s.gcr.io/kube-apiserver:v1.22.4
k8s.gcr.io/kube-apiserver:v1.21.5
k8s.gcr.io/kube-apiserver:v1.20.12
k8s.gcr.io/kube-apiserver:v1.23.1
k8s.gcr.io/kube-controller-manager:v1.22.4
k8s.gcr.io/kube-controller-manager:v1.21.5
k8s.gcr.io/kube-controller-manager:v1.20.12
k8s.gcr.io/kube-controller-manager:v1.23.1
k8s.gcr.io/etcd:3.5.1-0
k8s.gcr.io/etcd:3.4.13-0

coredns/coredns:1.8.4
coredns/coredns:1.8.3
coredns/coredns:1.8.0
coredns/coredns:1.6.9
coredns/coredns:1.6.3
coredns/coredns:1.8.6
```

Moreover If you need special kubernetes version you can provide images on your own. 
You need to modify only helm values that correspond to images definition!
Just to avoid issue within vcluster please use stable imges!

### Image registries according to different distros

#### K3s
Docker Hub (rancher) 

`One binary distribution`

| Component name          | URL                                  | Image URL               |
|-------------------------|:-------------------------------------|:------------------------|
| API Server + SQLLITE DB | https://hub.docker.com/r/rancher/k3s | rancher/k3s:\<version\> |

*ArgoCD deployment values*
```
- name: vcluster.image
  value: '<adjust>'
```

*Versions*:
- [ ] v1.23.3-k3s1
- [ ] v1.22.6-k3s1
- [ ] v1.21.9-k3s1
- [ ] v1.20.15-k3s1
- [ ] v1.19.13-k3s1
- [ ] v1.18.20-k3s1
- [ ] v1.17.17-k3s1

<!--
TBD!
* marked by X if tested + adding badge action status
-->

---

#### K0s
Docker Hub (k0sproject)

`One binnary distribution`

| Component name          | URL                                     | Image URL		         |
|-------------------------|:----------------------------------------|:---------------------------|
| API Server + SQLLITE DB | https://hub.docker.com/r/k0sproject/k0s | k0sproject/k0s:\<version\> |

*ArgoCD deployment values*
```
- name: vcluster.image
  value: '<adjust>'
```

*Versions*:

- [ ] v1.23.3-k0s.0
- [ ] v1.22.6-k0s.0

<!--
TBD!
* marked by X if tested + adding badge action status
-->


---

#### EKS
Amazon ECR Public Gallery
https://gallery.ecr.aws/

`Multiple components distribution`

| Component name     | URL                                                                   | Image URL                    				                |
|--------------------|:----------------------------------------------------------------------|:-------------------------------------------------------------------------|
| API Server         | https://gallery.ecr.aws/eks-distro/kubernetes/kube-apiserver          | public.ecr.aws/eks-distro/kubernetes/kube-apiserver:\<version>           |
| Controller Manager | https://gallery.ecr.aws/eks-distro/kubernetes/kube-controller-manager | public.ecr.aws/eks-distro/kubernetes/kube-controller-manager:\<version\> |
| ETCD Config DB     | https://gallery.ecr.aws/eks-distro/etcd-io/etcd                       | public.ecr.aws/eks-distro/etcd-io/etcd:\<version\>	                |
| CoreDNS            | https://gallery.ecr.aws/eks-distro/coredns/coredns                    | public.ecr.aws/eks-distro/coredns/coredns:\<version\>		        |

*ArgoCD deployment values*

```
- name: etcd.image
  value: '<adjust>'
- name: controller.image
  value: '<adjust>'
- name: api.image
  value: '<adjust>'
- name: coredns.image
  value: '<adjust>'
```

*Versions*:

- [ ] v1.21.5-eks-1-21-8
- [ ] v1.22.6-eks-1-22-1

<!--
TBD!
* marked by X if tested + adding badge action status
-->

---

#### K8s (vanilla)
Google Container Registry
https://console.cloud.google.com/gcr/images/google-containers/

| Component name     |                                                                                              | Image URL                                      |
|--------------------|:---------------------------------------------------------------------------------------------|:-----------------------------------------------|
| API Server         | https://console.cloud.google.com/gcr/images/google-containers/global/kube-apiserver          | k8s.gcr.io/kube-apiserver:\<version\>          |
| Controller Manager | https://console.cloud.google.com/gcr/images/google-containers/global/kube-controller-manager | k8s.gcr.io/kube-controller-manager:\<version\> |
| ETCD Config DB     | https://console.cloud.google.com/gcr/images/google-containers/global/etcd                    | k8s.gcr.io/etcd:\<version\>                    |


```
- name: etcd.image
  value: '<adjust>'
- name: controller.image
  value: '<adjust>'
- name: api.image
  value: '<adjust>'
```

*Versions*:

- [ ] v1.21.5
- [ ] v1.22.4
- [ ] v1.23.1
- [ ] v1.23.4

## Kubeconfig extraction

### k3s

#### 121
```
kubectl get secret -n k3s vc-vcluster-k3s-121 \
	-o jsonpath='{.data.config}' | base64 -d | \
	sed 's/^\([[:space:]]\+server:\).*/\1 \
	https:\/\/vcluster-k3s-121/' > ./tmp/kubeconfig-vcluster-k3s-121.yaml
```

#### 122
```
kubectl get secret -n k3s vc-vcluster-k3s-122 \
	-o jsonpath='{.data.config}' | base64 -d | \
	sed 's/^\([[:space:]]\+server:\).*/\1 \
	https:\/\/vcluster-k3s-122/' > ./tmp/kubeconfig-vcluster-k3s-122.yaml
```

#### 123
```
kubectl get secret -n k3s vc-vcluster-k3s-123 \
	-o jsonpath='{.data.config}' | base64 -d | \
	sed 's/^\([[:space:]]\+server:\).*/\1 \
	https:\/\/vcluster-k3s-123/' > ./tmp/kubeconfig-vcluster-k3s-123.yaml
```


<!--
TBD!
* marked by X if tested + adding badge action status
-->
