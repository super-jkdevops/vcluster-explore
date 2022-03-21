# Sample applications

`Before you start make sure that:`

- [X] Host Cluster - Istio Gateway contains http port definition (80)
```
$ kubectl get gw -n istio-ingress -o jsonpath='{.items[].spec.servers[1]}' | jq
{
  "hosts": [
    "*"
  ],
  "port": {
    "name": "http",
    "number": 80,
    "protocol": "HTTP"
  }
}
```

- [X] vCluster has been deployed alongside host cluster (please choose one of scenario doesn't matter which one!)

***example:***
```
$ vcluster list

 NAME               NAMESPACE   CREATED                         AGE
 vcluster-k3s-123   k3s         2022-03-21 09:07:10 +0100 CET   1h9m58s

$ kubectl get po -n k3s
NAME                                                        READY   STATUS    RESTARTS   AGE
vcluster-k3s-123-0                                          2/2     Running   0          70m
coredns-687874b9dd-zkt66-x-kube-system-x-vcluster-k3s-123   1/1     Running   0          69m
diagnose-x-apps-x-vcluster-k3s-123                          1/1     Running   0          46m
```

- [X] vCluster API has been exposed by istio vs
***example:***
```
$ kubectl get vs -n k3s
NAME               GATEWAYS                     HOSTS   AGE
vcluster-k3s-123   ["istio-ingress/vcluster"]   ["*"]   57m
```

- [X] vCluster kubeconfig has been extracted properly
***example:***
```
kubectl get secret -n k3s vc-vcluster-k3s-123 \
	-o jsonpath='{.data.config}' | base64 -d | \
	sed 's/^\([[:space:]]\+server:\).*/\1 \
	https:\/\/vcluster-k3s-123/' > ./tmp/kubeconfig-vcluster-k3s-123.yaml
```

## Diagnose pod vcluster
Simple busybox pod with no exposition

<b>manifests</b>: diagnose-pod-vcluster.yaml

```
kubectl apply -f manifest/samples/diagnose-pod-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
```

---

## Test deployment vcluster
Simple nginx manifest deployment contains 3 webserver instances, it is exposed via istio ingress controller

<b>manifests</b>: test-deployment-vcluster.yaml test-deployment-vcluster-vs.yaml

```
kubectl apply -f manifest/samples/test-deployment-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
kubectl apply -f manifest/samples/test-deployment-vcluster-vs.yaml --kubeconfig=<your vcluster kubeconfig>
```

---

## Test flask application vcluster
<b>manifests</b>: app01-deployment-vcluster.yaml app01-deployment-vcluster-vs.yaml

```
kubectl apply -f manifest/samples/app01-deployment-vcluster.yaml --kubeconfig=<your vcluster kubeconfig>
kubectl apply -f manifest/samples/app01-deployment-vcluster-vs.yaml --kubeconfig=<your vcluster kubeconfig>
```
