### Delete vcluster-a

```
helm delete vcluster -n team-a --repository-config=''
```

### Delete k3d hcluster
```
k3d cluster delete vcluster-poc
```