## Samples
You can find here several scenarios of vcluster deployment that can be used for special neds

### Fake k0s single vcluster assigned to specific host node
Can be used for github pipelines.

**host cluster assignment:** k3d-vcluster-demo
**vcluster distro:** k0s
**characteristic:** isolated,no synchronize with nodes
**accessible:** ClusterIP/ISTIO

---

### k8s vanilla multiple nodes synchronized & run across all host cluster nodes

**host cluster assignment:** all availabled nodes
**vcluster distro:** k8s vanilla
**characteristic:** synchronized across all cluster nodes
**accessible:** ClusterIP/ISTIO

---

### k8s vanilla fake multiple nodes run only on worker/agent nodes

**host cluster assignment:** agents/worker nodes
**vcluster distro:** k8s vanilla
**characteristic:** fake nodes with specific image
**accessible:** ClusterIP/ISTIO

---

### k3s single node run on master node with specific affinity rules

**host cluster assignment:** master node
**vcluster distro:** k3s
**characteristic:** synchronized with host nodes
**accessible:** ClusterIP/ISTIO


### eks multiple node synchronized and runs across all nodes in cluster

**host cluster assignment:** all available nodes
**vcluster distro:** eks
**characteristic:** synchronized with all nodes and objects expect of ingress
**accessible:** ClusterIP/ISTIO