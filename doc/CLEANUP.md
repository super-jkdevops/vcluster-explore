### Delete vcluster
```
helm delete vcluster-a -n team-a --repository-config=''
```

### Delete k3d hcluster
```
k3d cluster delete vcluster-poc
```