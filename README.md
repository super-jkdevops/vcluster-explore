# Vcluster

## What it is
Virtual clusters are fully working Kubernetes clusters that run on top of other Kubernetes clusters. Compared to fully separate "real" clusters, virtual clusters do not have their own node pools. Instead, they are scheduling workloads inside the underlying cluster while having their own separate control plane.

![Vcluster Architecture](https://www.vcluster.com/docs/media/diagrams/vcluster-architecture.svg)


## Main features:

- Lightweight 
- one binnary installation
- very easy to spinup
- build on top of edge solution as K3s
- rich variety of supported clusters (K3s/K0s/Vanila K8s)

## Comparation with others

![Comparation](https://www.vcluster.com/docs/media/vcluster-comparison.png)


Steps:
1. [Intall binary](./doc/INSTALL.md)
2. [Create host cluster K3D](./doc/HOST-CLUSTER.md)
3. [Create vcluster manually only testing purpose](./doc/VIRTUAL-CLUSTER.md)
4. [Bootstrap ArgoCD with necessary application](./doc/ARGOCD-INSTALL.md)
5. [ArgoCD deploy vcluster declarative way application deployment](./doc/ARGO-DEPLOYMENT.md)
6. [ArgoCD deployment multiple vcluster same namespace expose via istio](./doc/ARGOCD-MULTIPLE-VCLUSTER.md)
7. [Deploy sample application on vcluster accessing via istio](./SAMPLE-APPS-VCLUSTER.md)
8. [Sync scenarios cluster objects visibility](./doc/SYNC-OPTIONS.md)
9. [GitOps usecase in Github Actions](./doc/PIPELINE-EXAMPLE1.md)
10. [GitOps usecase using Tekton](./doc/PIPELINE-EXAMPLE2.md)
11. [Nesting vcluster (vcluster inside vcluster)](./doc/NESTING-VCLUSTER.md)
12. [Hints and usefull commands](./doc/HINTS.md)