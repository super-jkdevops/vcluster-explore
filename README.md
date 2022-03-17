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


## Table of contents:
1. [Intall binary](./doc/INSTALL.md)
2. [Create host cluster K3D](./doc/HOST-CLUSTER.md)
3. [Create Vcluster manually only testing purpose](./doc/VIRTUAL-CLUSTER.md)<br>
   3.1 [Vcluster commandline examples](./doc/VCLUSTER-COMMANDS.md)
4. [Bootstrap ArgoCD with necessary application](./doc/ARGOCD-INSTALL.md)
5. [ArgoCD deploy Vcluster declarative way application deployment](./doc/ARGO-DEPLOYMENT.md)
6. [ArgoCD deployment multiple vcluster same namespace expose via istio](./doc/ARGOCD-MULTIPLE-VCLUSTER.md)
7. [Different Vcluster distributions eks/k0s/k8s](./doc/VARIETY-OF-DISTROS.md)
8. [Different scenarios](./doc/SCENARIOS.md)
9.  [Deploy sample application on Vcluster accessing via istio](./SAMPLE-APPS-VCLUSTER.md)
10. [Sync scenarios cluster objects visibility](./doc/SYNC-OPTIONS.md)
11. [GitOps usecase in Github Actions](./doc/PIPELINE-EXAMPLE1.md)
12. [GitOps usecase using Tekton](./doc/PIPELINE-EXAMPLE2.md)
13. [Nesting Vcluster (Vcluster inside Vcluster)](./doc/NESTING-VCLUSTER.md)
14. [Hints and usefull commands](./doc/HINTS.md)
15. [Draft ssl replacement and comparation](./doc/CERTIFICATE-REPLACEMENT-ATTEMPT.md)
