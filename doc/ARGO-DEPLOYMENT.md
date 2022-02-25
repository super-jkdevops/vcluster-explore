# ArgoCD Deployment

## Requirements

* Kubernetes Cluster (K3d/Kind/K3s/K8s/AKS/GKE/EKS)
* ArgoCD installed and configured within Kubernetes

```
kubectl apply -f manifests/project.yaml
kubectl apply -f manifests/application.yaml
```