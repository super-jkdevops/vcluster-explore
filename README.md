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
2. [Create host cluster](./doc/HOST-CLUSTER.md)
3. [Create vcluster](./doc/VIRTUAL-CLUSTER.md)
4. [ArgoCD deploy vcluster declarative approach](./doc/ARGO-DEPLOYMENT.md)
5. [GitOps usecase in Github Actions](./doc/PIPELINE-EXAMPLE1.md)
6. [GitOps usecase using Tekton](./doc/PIPELINE-EXAMPLE2.md)
7. [Nesting vcluster (vcluster inside vcluster)](./doc/NESTING-VCLUSTER.md)
8. [Nesting FluxCD inside vcluster](./doce/FLUXCD-IN-VCLUSTER.md)
9. [Hints and usefull commands](./doc/HINTS.md)