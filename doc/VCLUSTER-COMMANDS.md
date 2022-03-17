# Usefull examples
Can find usefull examples that can be handy during daily basis

## List availabled Vclusters
```
vcluster list
```

***example:***
```
$ vcluster list

 NAME               NAMESPACE   CREATED                         AGE
 vcluster-k8s-123   k8s         2022-03-17 09:22:52 +0100 CET   1m13s
 vcluster-k8s-123   k8s         2022-03-17 09:22:53 +0100 CET   1m12s
 vcluster-k8s-123   k8s         2022-03-17 09:22:53 +0100 CET   1m12s
```

## Pause Vcluster
```
vcluster pause -n <vcluster_namespace> <vcluster_name>
```
* Please adjust vcluster_name and vcluster_namespace

***example:***
```
$ vcluster pause -n k8s vcluster-k8s-123
[info]   Scale down deployment k8s/vcluster-k8s-123...
[info]   Scale down deployment k8s/vcluster-k8s-123-api...
[info]   Scale down deployment k8s/vcluster-k8s-123-controller...
[info]   Scale down statefulSet k8s/vcluster-k8s-123-etcd...
[done] √ Successfully paused vcluster k8s/vcluster-k8s-123
```

`This is kubectl scale down wrapper!`

## Resume Vcluster
```
vcluster resume -n <vcluster_namespace> <vcluster_name>
```
* Please adjust vcluster_name and vcluster_namespace

***example:***
```
$ vcluster resume -n k8s vcluster-k8s-123
[done] √ Successfully resumed vcluster vcluster-k8s-123 in namespace 
```

## Connect Vcluster + adhoc commands
Checking cluster without exposing outside.
```
vcluster connect -n <vcluster_namespace> <vcluster_name> -- <kubectl commands>
```

***example:***
```
$ vcluster connect -n k8s vcluster-k8s-123 -- kubectl get no
NAME               STATUS   ROLES    AGE   VERSION
k3d-dev-agent-1    Ready    <none>   16h   v1.23.4
k3d-dev-agent-2    Ready    <none>   16h   v1.23.4
k3d-dev-agent-3    Ready    <none>   16h   v1.23.4
k3d-dev-agent-4    Ready    <none>   16h   v1.23.4
k3d-dev-server-0   Ready    <none>   16h   v1.23.4

$ vcluster connect -n k8s vcluster-k8s-123 -- kubectl get all -n kube-system
NAME                           READY   STATUS    RESTARTS   AGE
pod/coredns-687874b9dd-br5hk   1/1     Running   0          16h

NAME               TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.43.130.58   <none>        53/UDP,53/TCP,9153/TCP   16h

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   1/1     1            1           16h

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-687874b9dd   1         1         1       16h

$ vcluster connect -n k8s vcluster-k8s-123 -- kubectl create deployment test --image=nginx --replicas=2
deployment.apps/test created
$ vcluster connect -n k8s vcluster-k8s-123 -- kubectl get deployment,pods
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/test   2/2     2            2           17s

NAME                       READY   STATUS    RESTARTS   AGE
pod/test-8499f4f74-mc6bh   1/1     Running   0          17s
pod/test-8499f4f74-wxgfj   1/1     Running   0          17s
```
