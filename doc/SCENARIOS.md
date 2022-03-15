### Different scenarios according to different distributions

| nr | host distro | virtual distro | image version         | fake node | ha mode | synch mode   | manifests files |
|----|:----------------|:-----------|:----------------------|-----------|---------|--------------|-----------------|
| 1  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.21.9-k3s1     | yes       | no      | only objects | [k3s-v121](../scenarios/argo/fakeimages/k3s/vcluster-k3s-121.yaml)|
| 2  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.22.6-k3s1     | yes       | no      | only objects | [k3s-v122](../scenarios/argo/fakeimages/k3s/vcluster-k3s-122.yaml)|
| 3  | k3d/1.22.6+k3s1 | k3s | rancher/k3s:v1.23.3-k3s1     | yes       | no      | only objects | [k3s-v123](../scenarios/argo/fakeimages/k3s/vcluster-k3s-123.yaml)|
| 4  | k3d/1.22.6+k3s1 | k0s | k0sproject/k0s:v1.22.6-k0s.0 | yes       | no      | only objects | [k0s-v122](../scenarios/argo/fakeimages/k0s/vcluster-k0s-122.yaml)|
| 5  | k3d/1.22.6+k3s1 | k0s | k0sproject/k0s:v1.23.3-k0s.1 | yes       | no      | only objects | [k0s-v123](../scenarios/argo/fakeimages/k0s/vcluster-k0s-123.yaml)|
| 6  | k3d/1.22.6+k3s1 | eks | etcd:v3.4.16-eks-1-21-8, kube-controller-manager:v1.21.5-eks-1-21-8  kube-apiserver:v1.21.5-eks-1-21-8 | yes | yes | only objects | [eks-v121](../scenarios/argo/fakeimages/eks/vcluster-eks-121.yaml)|
| 7  | k3d/1.22.6+k3s1 | eks | etcd:v3.5.1-eks-1-22-1,  kube-controller-manager:v1.22.6-eks-1-22-1, kube-apiserver:v1.22.6-eks-1-22-1 | yes | yes | only objects | [eks-v122](../scenarios/argo/fakeimages/eks/vcluster-eks-122.yaml)|
| 8  | k3d/1.22.6+k3s1 | k8s | etcd:3.4.13-0, kube-controller-manager:v1.21.5, kube-apiserver:v1.21.5 | yes | yes | only objects | [k8s-v121](../scenarios/argo/fakeimages/k8s/vcluster-k8s-121.yaml)|
| 9  | k3d/1.22.6+k3s1 | k8s | etcd:3.5.1-0,  kube-controller-manager:v1.22.4, kube-apiserver:v1.22.4 | yes | yes | only objects | [k8s-v122](../scenarios/argo/fakeimages/k8s/vcluster-k8s-122.yaml)|
| 10 | k3d/1.22.6+k3s1 | k8s | etcd:3.5.1-0,  kube-controller-manager:v1.23.1, kube-apiserver:v1.23.1 | yes | yes | only objects | [k8s-v123](../scenarios/argo/fakeimages/k8s/vcluster-k8s-123.yaml)|

* ha mode   - enable high availability cluster components multiple API server, backend database, controllers etc
* sync mode - for fake clusters node synchronization stay disable on all dinmentions
