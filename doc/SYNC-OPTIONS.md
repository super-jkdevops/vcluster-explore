# Sync options possibilities
You can find all information about syncing respurces on [vcluster documentation](https://www.vcluster.com/docs/architecture/synced-resources).


I attached only several interesting cases. Following cluster was used:

distro:      k8s vanilla
version:     v1.23.1
node type:   fake
syncers:     3
etcds:       3
controllers: 3
apiservers:  3

## Critical settings
```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!! According to documentation several settings shouldn't be touched cause   !!!
!!! changes value may cause your vcluster non-functional. What does it mean  !!!
!!! that you will have problems with managing objects, connect vcluster etc. !!!
!!! Please do not modify following values it concerns both types of vcluster !!!
!!! (fake cluster nodes compilation also real nodes cluster!)		     !!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

***Checked by:***
- [X] Services:   sync.services.enabled 
- [X] Configmaps: sync.configmap.enabled
- [X] Nodes:      sync.pods.enabled
- [X] Endpoints:  sync.endpoints.enabled
- [X] Pods:       sync.pods.enabled
- [ ] Events:     sync.events.enabled

### Modification critical settings results (failure)

#### Services
Affecting communication between hcluster and vcluster:

```
vcluster connect -n tests vcluster -- kubectl get no
No resources found
```

---

#### ConfigMaps
Pods dangling in ContainerCreating status the reason is below:

```
  Type     Reason       Age                From               Message
  ----     ------       ----               ----               -------
  Normal   Scheduled    77s                default-scheduler  Successfully assigned default/test-8499f4f74-zfmfd to k3d-dev-agent-2
  Warning  FailedMount  13s (x8 over 77s)  kubelet            MountVolume.SetUp failed for volume "kube-api-access-66rjq" : configmap "kube-root-ca.crt-x-default-x-vcluster" not found
```

---

#### Endpoints
Access to service deployed within vcluster wasn't possible outside vcluster!
After istio ingress exposition connection is not anymore available.

scenario: 

1. Created test deployment inside vcluster + exposed via test service
2. Created virtual service exposition through ingress istio gateway to vcluster test service


```
curl http://vcluster
no healthy
```

After restore values for sync.endpoints.enabled to true:

```
curl -v http://vcluster
*   Trying 172.27.0.3:80...
* TCP_NODELAY set
* Connected to vcluster (172.27.0.3) port 80 (#0)
> GET / HTTP/1.1
> Host: vcluster
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< server: istio-envoy
< date: Thu, 17 Mar 2022 12:29:10 GMT
< content-type: text/html
< content-length: 615
< last-modified: Tue, 25 Jan 2022 15:03:52 GMT
< etag: "61f01158-267"
< accept-ranges: bytes
< x-envoy-upstream-service-time: 2
<
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
```
---

#### Pods
Pods were not visibled on host cluster cause pod synchronization is disabled.
Host cluster API, Vcluster API don't know about pods each other.


***vcluster***
```
$ vcluster connect -n tests vcluster -- kubectl get no
No resources found

$ vcluster connect -n tests vcluster -- kubectl apply -f test-deployment-vcluster.yaml
namespace/apps created
deployment.apps/test created
service/test created

$ vcluster connect -n tests vcluster -- kubectl get po -n apps
NAME                    READY   STATUS    RESTARTS   AGE
test-7c68854699-dmrl4   0/1     Pending   0          23s
test-7c68854699-f2xtg   0/1     Pending   0          23s
test-7c68854699-lgk8w   0/1     Pending   0          23s
```

***hcluster***
```
$ kubectl get po -n tests | grep test
$ kubectl get po -n tests
NAME                                   READY   STATUS    RESTARTS        AGE
vcluster-controller-7f96b5d8c8-n5bff   1/1     Running   0               10m
vcluster-etcd-0                        1/1     Running   0               10m
vcluster-api-5cc9d7d8d6-m57pn          1/1     Running   2 (9m56s ago)   10m
vcluster-559d647669-kzsff              1/1     Running   1 (9m21s ago)   10m
```
To sum up no evets about pods they remain in Pending state!

#### Events
Isn't critical cause cluster can function without it however it is hard to determine
pods status

***vcluster***
```
$ vcluster connect -n tests vcluster -- kubectl describe po -n apps | grep Events: -A 1
Events:                      <none>

--
Events:                      <none>

--
Events:                      <none>
```

***hcluster***
```
$ kubectl describe po -n tests test-7c68854699-d8wd8-x-apps-x-vcluster | grep Events: -A 20
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m32s  default-scheduler  Successfully assigned tests/test-7c68854699-d8wd8-x-apps-x-vcluster to k3d-dev-agent-1
  Normal  Pulling    3m30s  kubelet            Pulling image "nginx"
  Normal  Pulled     3m29s  kubelet            Successfully pulled image "nginx" in 1.046735999s
  Normal  Created    3m29s  kubelet            Created container nginx
  Normal  Started    3m29s  kubelet            Started container nginx
```

Let's assume vcluster users/admin will be not able to see kubernetes events that is big
disadvantage!


---

### Trying unrecognize sync option
It is reflect only to v0.6.0 cause don't know if new cotrollers will appear.

```
- name: sync.deployments.enabled
  value: true
```

```
F0317 13:03:33.001150       1 main.go:32] create controller context: unrecognized controller deployments, available controllers: configmaps, secrets, persistentvolumeclaims, ingresses, priorityclasses, networkpolicies, services, fake-nodes, storageclasses, endpoints, pods, events, persistentvolumes, poddisruptionbudgets, serviceaccounts, fake-persistentvolumes, nodes, volumesnapshots
```

<!--
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
-->
