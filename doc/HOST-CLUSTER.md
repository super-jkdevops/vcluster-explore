### Deploy K3d cluster using config file
```
./utins/create-k3d-cluster.sh
```


***example output:***

![create k3d cluster](../doc/images/k3d-cluster-creation.png)


`Be aware` 
<br/>Some changes after k3d binary update may become k3d/dev-cluster.conf incompatible.
It requires some additional steps to be migrated. Please correct values accordingly to version/release!

```console
k3d migrate config.yaml > config-migrated.yaml
mv config-migrated.yaml config.yaml
```
