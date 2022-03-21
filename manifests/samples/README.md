# Sample applications

`Before you start make sure that:`

- [X] Host Cluster - Istio Gateway contains http port definition (80)
- [X] vCluster has been deployed alongside host cluster (please choose one of scenario doesn't matter which one!)
- [X] vCluster kubeconfig has been extracted properly

## Diagnose pod vcluster
Simple busybox pod with no exposition

<b>manifests</b>: diagnose-pod-vcluster.yaml

```
kubectl apply -f manifest/samples/diagnose-pod-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
```

## Test deployment vcluster
Simple nginx manifest deployment contains 3 webserver instances, it is exposed via istio ingress controller

<b>manifests</b>: test-deployment-vcluster.yaml test-deployment-vcluster-vs.yaml

```
kubectl apply -f manifest/samples/test-deployment-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
kubectl apply -f manifest/samples/test-deployment-vcluster-vs.yaml --kubeconfig=<your vcluster kubeconfig>
```

## Test flask application vcluster
<b>manifests</b>: app01-deployment-vcluster.yaml app01-deployment-vcluster-vs.yaml

```
kubectl apply -f manifest/samples/app01-deployment-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
kubectl apply -f manifest/samples/app01-deployment-vcluster-vs.yaml --kubeconfig=<your vcluster kubeconfig>
```
