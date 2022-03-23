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
9.  [Vcluster sample application deployment](./doc/SAMPLE-APPS-VCLUSTER.md)
10. [Sync modes](./doc/SYNC-MODES.md)<br>
    10.1 [Sync critical objectives](./doc/SYNC-OPTIONS.md)<br>
    10.2 [Sync storage](./doc/SYNC-STORAGE.md)<br>
11. [Exposeing & accessing Vcluster](./doc/GENERAL-ACCESS.md)
    11.1 [Istio - passthrough](./doc/ISTIO-PASSTHROUGH.md)<br>
    11.2 [Istio - tls termination](./doc/ISTIO-TLS-TERMINATION.md)<br>
    11.3 [Istio - mutual tls](./doc/ISTIO-MTLS.md)<br>
12. [GitOps usecase in Github Actions](./doc/PIPELINE-EXAMPLE1.md)
13. [GitOps usecase using Tekton](./doc/PIPELINE-EXAMPLE2.md)
14. [Nesting Vcluster (Vcluster inside Vcluster)](./doc/NESTING-VCLUSTER.md)
15. [Hints and usefull commands](./doc/HINTS.md)
16. [Draft ssl replacement and comparation](./doc/CERTIFICATE-REPLACEMENT-ATTEMPT.md)
