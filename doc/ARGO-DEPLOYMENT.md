# ArgoCD Deployment

## Requirements

* Kubernetes Cluster (K3d/Kind/K3s/K8s/AKS/GKE/EKS)
* ArgoCD installed and configured within Kubernetes

2 available options:

- [X] Loadbalancer
```
kubectl apply -f manifests/project.yaml
kubectl apply -f manifests/application-lb.yaml
```

- [X] Ingress (Istio)
```
kubectl apply -f manifests/project.yaml
kubectl apply -f manifests/application-ing.yaml
```