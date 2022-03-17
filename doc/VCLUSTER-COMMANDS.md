# Usefull options
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

```
$ vcluster pause -n k8s vcluster-k8s-123
[info]   Scale down deployment k8s/vcluster-k8s-123...
[info]   Scale down deployment k8s/vcluster-k8s-123-api...
[info]   Scale down deployment k8s/vcluster-k8s-123-controller...
[info]   Scale down statefulSet k8s/vcluster-k8s-123-etcd...
[done] √ Successfully paused vcluster k8s/vcluster-k8s-123
```
