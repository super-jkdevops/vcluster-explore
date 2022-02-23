I found some discrepancies according to documentation.


- [X] vcluster.yaml incorrect syntax
    It should be:
```
serviceCIDR: "10.43.0.1/12"
vcluster:
  image: rancher/k3s:v1.19.5-k3s2 
```

instead

```
vcluster:
  image: rancher/k3s:v1.19.5-k3s2    
  extraArgs:
    - --service-cidr=10.96.0.0/12    
```