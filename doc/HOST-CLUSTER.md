### Deploy K3d cluster using config file
```
k3d cluster create --config=k3d/config-vcluster.yaml
```

`Be aware` 
<br/>Some changes in k3d may become k3d/config.yaml incompatible.
It requires some additional steps to be migrated.

```console
k3d migrate config.yaml > config-migrated.yaml
mv config-migrated.yaml config.yaml
```
