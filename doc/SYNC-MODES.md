# Syncing modes
We can distinct nodes types vcluster according to 2 node syncing modes

## Fakenodes
They are fully grained clusters closed in specific kubernetes version. So far the best option
for testing application in context to specific kubernetes version. It is also very handy in
pipeline builds/tests.

## Realnodes
They are synced with Host clusters it means that runtime will be shared from host cluster. 
It is rather for sharing host cluster version across smaller vcluster pieces.

More detail about information can be found [here](https://www.vcluster.com/docs/architecture/nodes#node-syncing-modes)

### Activation values ArgoCD declarative
ArgoCD application manifests

#### Fakenodes

```
parameters:
- name: sync.fake-nodes.enabled
  value: 'true'
```

** This settings is activate by default so you don't need to modify argoCD app values. **

#### Realnodes

```
parameters:
- name: sync.nodes.enabled
  value: 'true'
- name: sync.nodes.syncAllNodes
  value: 'true'
```

** Second parameter is optional however if you would like to spread vcluster across whole hcluster
then value can be set to true.**

---

### Activation values helm/vcluster imperative

#### Fakenodes
```
sync:
  fake-nodes:
    enabled: true
```

#### Realnodes

```
sync:
  nodes:
    enabled: true
    syncAllNodes: true
```

**Very important!**
`These settings cannot be used combined because they are mutually exclusive. So at the begining we must
deside which way suits better.`
