# Istio passthrough Vcluster access
So far only this method works together with vcluster. Istio become transparend and uses
certificates delivered by vcluster itself.


### Create Gateway
```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: <your gateway cluster name>
  namespace: istio-ingress
spec:
  selector:
    istio: ingress
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: PASSTHROUGH
    hosts:
    - "<your-vcluster-host-fqdn>"
```


### Create Virtual Service
```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: <your virtual service name>
  namespace: <namespace reside vcluster>
spec:
  hosts:
  - "<your vcluster fqdn>"
  gateways:
  - istio-ingress/<your vcluster gateway>
  tls:
  - match:
    - port: 443
      sniHosts:
      - "your vcluster fqdn"
    route:
    - destination:
        host: <your vcluster service reaside in vcluster namespace host cluster>
        port:
          number: 443
```

Be aware and adjust manifest to your needs:

```console
<your gateway cluster name>
<your-vcluster-host-fqdn>
<your virtual service name>
<namespace reside vcluster>
<your vcluster gateway>
<your vcluster service reaside in vcluster namespace host cluster>
```

Particular examples can be found in each istio directory scenario.

```
.
└── fakenodes
    ├── eks
    │   └── istio
    │       ├── gateways
    │       │   └── gw-vcluster-eks.yaml
    │       └── virtual-services
    │           ├── vs-vcluster-eks-121.yaml
    │           └── vs-vcluster-eks-122.yaml
    ├── k0s
    │   └── istio
    │       ├── gateways
    │       │   └── gw-vcluster-k0s.yaml
    │       └── virtual-services
    │           ├── vs-vcluster-k0s-121.yaml
    │           ├── vs-vcluster-k0s-122.yaml
    │           └── vs-vcluster-k0s-123.yaml
    ├── k3s
    │   └── istio
    │       ├── gateways
    │       │   └── gw-vcluster-k3s.yaml
    │       └── virtual-services
    │           ├── istio-vs-ssl-term-vcluster-k3s-123.yaml
    │           ├── vs-vcluster-k3s-121.yaml
    │           ├── vs-vcluster-k3s-122.yaml
    │           └── vs-vcluster-k3s-123.yaml
    └── k8s
        └── istio
            ├── gateways
            │   └── gw-vcluster-k8s.yaml
            └── virtual-services
                ├── vs-vcluster-k8s-121.yaml
                ├── vs-vcluster-k8s-122.yaml
                ├── vs-vcluster-k8s-123-4.yaml
                └── vs-vcluster-k8s-123.yaml
```