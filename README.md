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
3. [Create Vcluster manually testing purpose](./doc/VIRTUAL-CLUSTER.md)<br>
   3.2 [Running Vcluster on arm64](./doc/VCLUSTER-ARM64.md)
   3.2 [Vcluster commandline examples](./doc/VCLUSTER-COMMANDS.md)
4. [Bootstrap ArgoCD with necessary application](./doc/ARGOCD-INSTALL.md)
5. [ArgoCD deploy Vcluster declarative way application deployment](./doc/ARGO-DEPLOYMENT.md)<br>
   5.1 [ArgoCD deploy multiple vcluster same namespace then access via istio](./doc/ARGOCD-MULTIPLE-VCLUSTER.md)<br>
   5.2 [Add Vclusters to Argo](./doc/VCLUSTER-ADD-ARGOCD.md)<br>
6. [Different Vcluster scenarios](./doc/SCENARIOS.md)
7. [Vcluster sample application deployment](./doc/SAMPLE-APPS-VCLUSTER.md)
8. [Exposeing & accessing Vcluster](./doc/GENERAL-ACCESS.md)<br>
    8.1 [Istio - passthrough](./doc/ISTIO-PASSTHROUGH.md)<br>
    8.2 [Istio - tls termination](./doc/ISTIO-TLS-TERMINATION.md)<br>
    8.3 [Istio - mutual tls](./doc/ISTIO-MTLS.md)<br>
9. [Sync modes](./doc/SYNC-MODES.md)<br>
    9.1 [Sync critical objectives](./doc/SYNC-OPTIONS.md)<br>
    9.2 [Sync storage](./doc/SYNC-STORAGE.md)<br>
10. [GitOps usecase in Github Actions](./doc/PIPELINE-EXAMPLE1.md)
11. [GitOps usecase using Tekton](./doc/PIPELINE-EXAMPLE2.md)
12. [Nesting Vcluster (Vcluster inside Vcluster)](./doc/NESTING-VCLUSTER.md)
13. [Hints and usefull commands](./doc/HINTS.md)
14. [Draft ssl replacement and comparation](./doc/CERTIFICATE-REPLACEMENT-ATTEMPT.md)
