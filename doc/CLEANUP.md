### Delete vcluster-a

```console
helm delete vcluster -n team-a --repository-config=''
```

### Delete k3d hcluster
```console
k3d cluster delete vcluster-poc
```
