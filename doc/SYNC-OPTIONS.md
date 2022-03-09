# Sync options possibilities
You can find all information about syncing respurces on [vcluster documentation](https://www.vcluster.com/docs/architecture/synced-resources).

I attached only several interesting scenarios


**Real** - giving impression that user is operating on real cluster:

sets of values:

```
sync:
  # resources
  services:
    enabled: true
  configmaps:
    enabled: true
  secrets:
    enabled: true
  endpoints:
    enabled: true
  pods:
    enabled: true
  events:
    enabled: true
  persistentvolumeclaims:
    enabled: true
  ingresses:
    enabled: true

  # nodes
  fake-nodes:
    enabled: true 
  fake-persistentvolumes:
    enabled: true 

  # main
  nodes:
    enabled: true
    syncAllNodes: true
    nodeSelector: ""
    syncNodeChanges: false
  
  # storage, network & hpa
  persistentvolumes:
    enabled: false
  storageclasses:
    enabled: false
  priorityclasses:
    enabled: false
  networkpolicies:
    enabled: false
  volumesnapshots:
    enabled: false
  poddisruptionbudgets:
    enabled: false
```
Assume user has access and see nodes also (kubectl get no command will show nodes list)

```

```

---

**Closed in black box** - giving impression that user has very cutted and limited

```
sync:
  # resources
  services:
    enabled: true
  configmaps:
    enabled: true
  secrets:
    enabled: true
  endpoints:
    enabled: true
  pods:
    enabled: true
  events:
    enabled: true
  persistentvolumeclaims:
    enabled: true
  ingresses:
    enabled: false

  # nodes
  fake-nodes:
    enabled: false 
  fake-persistentvolumes:
    enabled: false 

  # main
  nodes:
    enabled: false
    syncAllNodes: false
    nodeSelector: ""
    syncNodeChanges: false
  
  # storage, network & hpa
  persistentvolumes:
    enabled: false
  storageclasses:
    enabled: false
  priorityclasses:
    enabled: false
  networkpolicies:
    enabled: false
  volumesnapshots:
    enabled: false
  poddisruptionbudgets:
    enabled: false
```

Cluster is really limited cluster nodes are invisible:

```
$ kubectl get no -o wide
No resources found
```

I came a cross issue when I tried to list newly created pods:

```
NAME                        READY   STATUS    RESTARTS   AGE
pod/test-7c68854699-x85z8   0/1     Pending   0          21s
pod/test-7c68854699-8fczs   0/1     Pending   0          21s
pod/test-7c68854699-44zn2   0/1     Pending   0          21s
```

`Showing up Pending state, it looks me to bug. The reason of pending state is that
pods status is exposing to the cluster by nodes and nodes are not visible!`